package org.firebirdsql.documentation.asciidoc

import groovy.transform.CompileStatic
import org.asciidoctor.gradle.base.AsciidoctorUtils
import org.asciidoctor.gradle.jvm.pdf.AsciidoctorPdfTask
import org.firebirdsql.documentation.DocConfigExtension
import org.firebirdsql.documentation.DocConfigurable
import org.gradle.api.file.FileTree
import org.gradle.api.provider.Property
import org.gradle.api.provider.Provider
import org.gradle.api.tasks.*
import org.gradle.api.tasks.options.Option
import org.gradle.api.tasks.util.PatternSet
import org.gradle.workers.WorkerExecutor

import javax.inject.Inject

import static org.gradle.api.tasks.PathSensitivity.RELATIVE

@CompileStatic
class FbAsciidocPdfTask extends AsciidoctorPdfTask implements DocConfigurable {

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
    @Option(option = "docId", description = 'The document to generate (eg fblangref25), this should match the directory name of the document (eg fblangref25 for src/asciidoc/en/refdocs/fblangref25)')
    final Property<String> docId = project.objects.property(String)

    @Input
    final Provider<String> includePattern = project.provider {
        if (docId.present) {
            return "${baseName.get()}/**/${docId.get()}/*".toString()
        }
        return "${baseName.get()}/**/*".toString()
    }

    // This is a bit of a hack to get the include pattern to be updated and to force dirty detection
    @InputFiles
    @IgnoreEmptyDirectories
    @SkipWhenEmpty
    @PathSensitive(RELATIVE)
    final Provider<FileTree> forceSourceFiles = includePattern.map { includePatternValue ->
        clearSources()
        sources(includePatternValue)
        def patternSet = new PatternSet().include(includePatternValue)
        if (languages.empty) {
            return project.fileTree(sourceDir)
                    .matching(patternSet)
                    .filter(AsciidoctorUtils.ACCEPT_ONLY_FILES)
                    .asFileTree
        }
        return languages.sum { lang ->
            project.fileTree(new File(sourceDir, lang))
                    .matching(patternSet)
                    .filter(AsciidoctorUtils.ACCEPT_ONLY_FILES)
                    .asFileTree
        } as FileTree
    }

    @Inject
    FbAsciidocPdfTask(WorkerExecutor we) {
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
        outputDirProperty.set(asciidocConfig.outputDir.dir('pdf'))
        setLanguage('en')
    }
}
