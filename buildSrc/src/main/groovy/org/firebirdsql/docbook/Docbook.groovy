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
package org.firebirdsql.docbook

import javax.xml.parsers.SAXParserFactory
import javax.xml.transform.Result
import javax.xml.transform.Source
import javax.xml.transform.Transformer
import javax.xml.transform.TransformerFactory
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

import com.icl.saxon.TransformerFactoryImpl
import org.apache.xml.resolver.CatalogManager
import org.apache.xml.resolver.tools.CatalogResolver
import org.xml.sax.InputSource
import org.xml.sax.XMLReader

// Parts derived from https://github.com/spring-projects/spring-build-gradle

class Docbook extends DefaultTask {

    @Input
    String extension = 'html'

    @Input
    final Property<String> xdir = project.objects.property(String)

    @InputDirectory
    final DirectoryProperty docRoot = project.objects.directoryProperty()

    @Input
    final Property<String> sourceFileName = project.objects.property(String)

    @Internal
    final DirectoryProperty styleDir = project.objects.directoryProperty()

    @Input
    final Property<String> stylesheet = project.objects.property(String)

    @Optional
    @Input
    final Property<String> outputFilename = project.objects.property(String)

    @InputFile
    final Provider<RegularFile> styleSheetFile = styleDir.file(stylesheet)

    @Internal
    final DirectoryProperty outputRoot = project.objects.directoryProperty()

    @OutputDirectory
    final Provider<Directory> docsOutput = outputRoot.dir(xdir)

    Docbook() {
        xdir.set('.')
    }

    void configureWith(DocbookExtension extension) {
        docRoot.set(extension.docRoot)
        styleDir.set(extension.styleDir)
        outputRoot.set(extension.outputRoot)
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

        SAXParserFactory factory = new org.apache.xerces.jaxp.SAXParserFactoryImpl()
        factory.setXIncludeAware(true)
        docsOutput.get().asFile.mkdirs()

        File srcFile = docRoot.file(sourceFileName).get().asFile
        String outputFilenameValue = outputFilename
                .orElse(nameWithoutFileExtension(srcFile) + '.' + extension)
                .get()
        File outputFile = docsOutput.get().file(outputFilenameValue).asFile

        Result result = new StreamResult(outputFile.getAbsolutePath())
        CatalogResolver resolver = new CatalogResolver(createCatalogManager())
        InputSource inputSource = new InputSource(srcFile.getAbsolutePath())

        XMLReader reader = factory.newSAXParser().getXMLReader()
        reader.setEntityResolver(resolver)
        TransformerFactory transformerFactory = new TransformerFactoryImpl()
        transformerFactory.setURIResolver(resolver)
        URL url = styleSheetFile.get().asFile.toURI().toURL()
        Source source = new StreamSource(url.openStream(), url.toExternalForm())
        Transformer transformer = transformerFactory.newTransformer(source)

        preTransform(transformer, srcFile, outputFile)

        transformer.transform(new SAXSource(reader, inputSource), result)

        postTransform(outputFile)
    }

    protected void preTransform(Transformer transformer, File sourceFile, File outputFile) {
    }

    protected void postTransform(File outputFile) {
    }

    private CatalogManager createCatalogManager() {
        CatalogManager manager = new CatalogManager()
        manager.setIgnoreMissingProperties(true)
        ClassLoader classLoader = this.getClass().getClassLoader()
        StringBuilder builder = new StringBuilder()
        String docbookCatalogName = "docbook/catalog.xml"
        URL docbookCatalog = classLoader.getResource(docbookCatalogName)

        if (docbookCatalog == null) {
            throw new IllegalStateException("Docbook catalog " + docbookCatalogName + " could not be found in " + classLoader)
        }

        builder.append(docbookCatalog.toExternalForm())

        Enumeration enumeration = classLoader.getResources("catalog.xml")
        while (enumeration.hasMoreElements()) {
            builder.append(';')
            URL resource = (URL) enumeration.nextElement()
            builder.append(resource.toExternalForm())
        }
        String catalogFiles = builder.toString()
        manager.setCatalogFiles(catalogFiles)
        return manager
    }

    static String nameWithoutFileExtension(File file) {
        String name = file.getName()
        int separator = name.lastIndexOf('.')
        if (separator > 0) {
            return name.substring(0, separator)
        }
        return name
    }

}
