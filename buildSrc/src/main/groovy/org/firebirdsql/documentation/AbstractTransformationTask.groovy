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
package org.firebirdsql.documentation

import org.gradle.api.DefaultTask
import org.gradle.api.file.Directory
import org.gradle.api.file.DirectoryProperty
import org.gradle.api.file.RegularFile
import org.gradle.api.provider.Property
import org.gradle.api.provider.Provider
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.InputDirectory
import org.gradle.api.tasks.Internal
import org.gradle.api.tasks.Optional
import org.gradle.api.tasks.OutputDirectory
import org.gradle.api.tasks.OutputFile
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.options.Option

import groovy.transform.CompileStatic

// Parts derived from https://github.com/spring-projects/spring-build-gradle

@CompileStatic
abstract class AbstractTransformationTask extends DefaultTask implements DocConfigurable {

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
    @Option(option = 'baseName', description = 'The base name of the documentation set, without language suffix (eg firebirddocs, rlsnotes, papers or refdocs)')
    final Property<String> baseName = project.objects.property(String)

    /**
     * Language of the documentation (eg 'de', 'ru').
     * <p>
     * Should not be set to 'en' for English.
     * </p>
     */
    @Input
    @Optional
    @Option(option = 'language', description = 'The two letter language code for output (eg de), don\'t specify for English')
    final Property<String> language = project.objects.property(String)

    /**
     * ID of the (sub-)document to render
     */
    @Input
    @Optional
    @Option(option = "docId", description = 'The document id of the (sub)-document to generate (eg nullguide)')
    final Property<String> docId = project.objects.property(String)

    /**
     * The filename (without extension) of the resulting document. Defaults to the docId if specified, otherwise the
     * setName.
     */
    @Input
    @Optional
    @Option(option = "docName", description = 'The filename (without extension) of the resulting document. Defaults to the docId, or otherwise the set name (base name + language).')
    final Property<String> docName = project.objects.property(String)

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
            .dir(setName.map({ setNameValue -> "${outputTypeName.get()}-${setNameValue}" }))

    /**
     * Main output file for this task.
     * <p>
     * Some variants of this task (eg {@link org.firebirdsql.documentation.docbook.DocbookHtml} with html style), can produces multiple files, then this will
     * point to the initial file.
     * </p>
     */
    @OutputFile
    final Provider<RegularFile> mainOutputFile = docsOutput.map { docsOutputDir ->
        docsOutputDir.file("${docName.get()}.${extension}")
    }

    AbstractTransformationTask(String extension) {
        this.extension = extension
        docName.convention(project.provider {
            if (docId.present) {
                return docId.get()
            }
            return setName.get()
        })
    }

    @Override
    void configureWith(DocConfigExtension extension) {
        docRoot.convention(extension.docRoot)
        outputRoot.convention(extension.outputRoot)
        configRootDir.convention(extension.configRootDir)
        baseName.convention(extension.defaultBaseName)
    }

    @TaskAction
    abstract void transform()

    /**
     * Configures this task with the values of {@code baseName}, {@code language}, {@code docId} and {@code docName}
     * from {@code other}.
     *
     * @param other The other transformation task to copy from
     */
    void configureWith(AbstractTransformationTask other) {
        baseName.set(other.baseName)
        language.set(other.language)
        docId.set(other.docId)
        docName.set(other.docName)
    }
}
