/*
 * Copyright 2002-2018 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.firebirdsql.documentation.docbook

import org.gradle.api.file.CopySpec
import org.gradle.api.file.FileCollection
import org.gradle.api.provider.SetProperty
import org.gradle.api.tasks.options.Option

import com.icl.saxon.TransformerFactoryImpl
import groovy.transform.CompileStatic
import org.apache.xerces.jaxp.SAXParserFactoryImpl
import org.firebirdsql.documentation.DocConfigExtension
import org.gradle.api.file.FileTree

import javax.xml.transform.Transformer
import javax.xml.transform.sax.SAXSource
import javax.xml.transform.stream.StreamResult
import javax.xml.transform.stream.StreamSource

import org.gradle.api.DefaultTask
import org.gradle.api.file.Directory
import org.gradle.api.file.DirectoryProperty
import org.gradle.api.file.RegularFile
import org.gradle.api.logging.LogLevel
import org.gradle.api.provider.Property
import org.gradle.api.provider.Provider
import org.gradle.api.tasks.*

import org.apache.xml.resolver.CatalogManager
import org.apache.xml.resolver.tools.CatalogResolver
import org.xml.sax.InputSource

import static org.gradle.api.file.DuplicatesStrategy.EXCLUDE

// Parts derived from https://github.com/spring-projects/spring-build-gradle

@CompileStatic
class Docbook extends DefaultTask {

    @Input
    String extension

    /**
     * Output type name, used for generating the output folder
     */
    @Input
    final Property<String> outputTypeName = project.objects.property(String)

    /**
     * 'baseName' is the base set name, without language suffix.
     * <p>
     * Currently it can be firebirddocs, rlsnotes, papers or refdocs.
     * </p>
     */
    @Input
    @Option(option = 'baseName', description = "The base name of the documentation set, without language suffix")
    final Property<String> baseName = project.objects.property(String)

    /**
     * Language of the documentation (eg 'de', 'ru').
     * <p>
     * Should not be set to 'en' for English.
     * </p>
     */
    @Input
    @Optional
    @Option(option = 'language', description = "Sets two letter language code for output, don't specify for English")
    final Property<String> language = project.objects.property(String)

    /**
     * setName is the base filename of the set, without extension, but already including
     * the language suffix (if applicable), e.g. firebirddocs, firebirddocs-ru, firebirddocs-es.
     */
    @Internal
    final Provider<String> setName = project.provider {
        if (language.present) {
            return "${baseName.get()}-${language.get()}".toString()
        }
        return baseName.get()
    }

    /**
     * Sources root for the documentation
     */
    @Internal
    final DirectoryProperty docRoot = project.objects.directoryProperty()

    /**
     * Sources root for the set
     */
    @InputDirectory
    final Provider<Directory> setSource = docRoot.dir(setName)

    /**
     * ID of the (sub-)document to render
     */
    @Input
    @Optional
    @Option(option="docId", description = "Specify the document id (eg nullguide)")
    final Property<String> docId = project.objects.property(String)

    /**
     * Directory containing the XSLT files
     */
    @InputDirectory
    final DirectoryProperty styleDir = project.objects.directoryProperty()

    /**
     * Base name of the XSLT (eg html, fo)
     */
    @Input
    final Property<String> stylesheetBaseName = project.objects.property(String)

    /**
     * XSLT filename (eg src/docs/xsl/html-firebirddocs.xsl)
     */
    @InputFile
    final Provider<RegularFile> styleSheetFile = styleDir
            .file(baseName.map({baseNameValue -> "${stylesheetBaseName.get()}-${baseNameValue}.xsl"}))

    @Internal
    final DirectoryProperty outputRoot = project.objects.directoryProperty()

    @Internal
    final DirectoryProperty configRootDir = project.objects.directoryProperty()

    @InputDirectory
    final Provider<Directory> languageConfigDir = project.provider {
        if (language.present) {
            def candidateDir = configRootDir.dir(language).get()
            def candidateDirFile = candidateDir.asFile
            if (candidateDirFile.isDirectory()) {
                // We have a language specific config directory
                return candidateDir
            }
        }
        return configRootDir.get()
    }

    @OutputDirectory
    final Provider<Directory> docsOutput = outputRoot
            .dir(setName.map({setNameValue -> "${outputTypeName.get()}-${setNameValue}"}))

    @Input
    final Provider<FileTree> imageSource = project.provider {
        return project.fileTree(docRoot.dir('images')) +
                project.fileTree(docRoot.dir(baseName.map {baseNameValue -> "$baseNameValue/images" })) +
                project.fileTree(docRoot.dir(setName.map {setNameValue -> "$setNameValue/images" }))
    }

    @Input
    final SetProperty<String> imageExcludes = project.objects.setProperty(String)

    @Input
    @Optional
    final Property<FileCollection> extraFilesToOutput = project.objects.property(FileCollection)

    @Internal
    final Provider<String> docName = project.provider {
        if (docId.present) {
            return docId.get()
        }
        return setName.get()
    }

    Docbook() {
        this('html')
    }

    Docbook(String extension) {
        this.extension = extension
    }

    void configureWith(DocConfigExtension extension) {
        docRoot.set(extension.docRoot)
        styleDir.set(extension.styleDir)
        outputRoot.set(extension.outputRoot)
        configRootDir.set(extension.configRootDir)
        baseName.convention(extension.defaultBaseName)
    }

    @TaskAction
    final void transform() {
        // the docbook tasks issue spurious content to the console. redirect to INFO level
        // so it doesn't show up in the default log level of LIFECYCLE unless the user has
        // run gradle with '-d' or '-i' switches -- in that case show them everything
        switch (project.gradle.startParameter.logLevel) {
            case LogLevel.DEBUG:
            case LogLevel.INFO:
                break
            default:
                logging.captureStandardOutput(LogLevel.INFO)
                logging.captureStandardError(LogLevel.INFO)
        }

        def factory = new SAXParserFactoryImpl()
        factory.setXIncludeAware(true)
        docsOutput.get().asFile.mkdirs()

        def setNameValue = setName.get()
        def srcFile = docRoot.get().file("${setNameValue}/${setNameValue}.xml").asFile
        def outputFile = docsOutput.get().file("${docName.get()}.${extension}").asFile

        def result = new StreamResult(outputFile)
        def resolver = new CatalogResolver(createCatalogManager())
        def inputSource = new InputSource(srcFile.getAbsolutePath())

        def reader = factory.newSAXParser().getXMLReader()
        reader.setEntityResolver(resolver)
        def transformerFactory = new TransformerFactoryImpl()
        transformerFactory.setURIResolver(resolver)
        def url = styleSheetFile.get().asFile.toURI().toURL()
        def source = new StreamSource(url.openStream(), url.toExternalForm())
        def transformer = transformerFactory.newTransformer(source)

        preTransform(transformer, srcFile, outputFile)

        transformer.transform(new SAXSource(reader, inputSource), result)

        postTransform(outputFile)
    }

    protected void preTransform(Transformer transformer, File sourceFile, File outputFile) {
        copyImages()
        copyExtraFiles()
        if (docId.isPresent()) {
            // rootid is used in the stylesheet to represent the root of the document
            transformer.setParameter("rootid", docId.get())
        }
    }

    protected void postTransform(File outputFile) {
    }

    private void copyImages() {
        project.copy { CopySpec copySpec ->
            copySpec.from imageSource.get()
            copySpec.exclude imageExcludes.get()
            copySpec.duplicatesStrategy = EXCLUDE
            copySpec.into docsOutput.get().dir('images')
        }
    }

    private void copyExtraFiles() {
        if (extraFilesToOutput.present) {
            project.copy { CopySpec copySpec ->
                copySpec.from extraFilesToOutput.get()
                copySpec.into docsOutput.get()
            }
        }
    }

    private CatalogManager createCatalogManager() {
        def manager = new CatalogManager()
        manager.setIgnoreMissingProperties(true)
        def classLoader = this.getClass().getClassLoader()
        def builder = new StringBuilder()
        def docbookCatalogName = "docbook/catalog.xml"
        def docbookCatalog = classLoader.getResource(docbookCatalogName)

        if (docbookCatalog == null) {
            throw new IllegalStateException("Docbook catalog " + docbookCatalogName + " could not be found in " + classLoader)
        }

        builder.append(docbookCatalog.toExternalForm())

        def enumeration = classLoader.getResources("catalog.xml")
        while (enumeration.hasMoreElements()) {
            builder.append(';')
            def resource = enumeration.nextElement()
            builder.append(resource.toExternalForm())
        }
        manager.setCatalogFiles(builder.toString())
        return manager
    }

}
