package org.firebirdsql.documentation.asciidoc

import groovy.transform.CompileStatic
import org.asciidoctor.gradle.jvm.AsciidoctorTask
import org.firebirdsql.documentation.DocConfigExtension
import org.firebirdsql.documentation.DocConfigurable
import org.gradle.api.file.DirectoryProperty
import org.gradle.api.provider.Property
import org.gradle.api.provider.Provider
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.InputDirectory
import org.gradle.api.tasks.Optional
import org.gradle.api.tasks.options.Option
import org.gradle.workers.WorkerExecutor

import javax.inject.Inject

@CompileStatic
class FbAsciidocHtmlTask extends AsciidoctorTask implements DocConfigurable {

    /**
     * 'baseName' is the base set name, without language suffix.
     * <p>
     * Currently it can be firebirddocs, rlsnotes, papers or refdocs. Defaults to firebirddocs.
     * </p>
     */
    @Input
    @Optional
    @Option(option = 'baseName', description = 'The base name of the documentation set, without language suffix (eg firebirddocs, rlsnotes, papers or refdocs), defaults to firebirddocs')
    final Property<String> baseName = project.objects.property(String).convention('firebirddocs')

    /**
     * The name of the document to build.
     * <p>
     * Technically this must the name of the directory containing the document.
     * </p>
     */
    @Input
    @Optional
    @Option(option = "docId", description = 'The document to generate (eg fblangref25), this should match the folder name of the document (eg fblangref25 for src/asciidoc/en/refdocs/fblangref25)')
    final Property<String> docId = project.objects.property(String)

    @InputDirectory
    final DirectoryProperty stylesDir = project.objects.directoryProperty()

    @Input
    final Provider<String> includePattern = project.provider {
        if (docId.present) {
            return "${baseName.get()}/**/${docId.get()}/*".toString()
        }
        return "${baseName.get()}/**/*".toString()
    }

    @Inject
    FbAsciidocHtmlTask(WorkerExecutor we) {
        super(we)
    }

    /**
     * Language of the documentation (eg 'de', 'ru').
     * <p>
     * Defaults to 'en' for English.
     * </p>
     */
    @Option(option = 'language', description = 'The two letter language code for output (eg de), defaults to en for English')
    void setLanguage(String language) {
        setLanguages([ language ])
    }

    @Override
    void configureWith(DocConfigExtension docConfigExtension) {
        def asciidocConfig = docConfigExtension.asciidocConfig
        sourceDirProperty.set(asciidocConfig.sourceDir)
        outputDirProperty.set(asciidocConfig.outputDir.dir('html'))
        stylesDir.set(asciidocConfig.themeDir.dir(asciidocConfig.htmlTheme))
        setLanguage('en')
    }
}
