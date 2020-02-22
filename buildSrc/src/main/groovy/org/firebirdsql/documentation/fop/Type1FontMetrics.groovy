package org.firebirdsql.documentation.fop

import org.gradle.api.DefaultTask
import org.gradle.api.file.RegularFile
import org.gradle.api.provider.Property
import org.gradle.api.provider.Provider
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.Optional
import org.gradle.api.tasks.OutputFile
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.options.Option

import groovy.transform.CompileStatic
import groovy.util.logging.Slf4j
import org.apache.fop.fonts.apps.PFMReader
import org.w3c.dom.Document

/**
 * Produces font metrics for Adobe Type 1 Fonts in .pfm files.
 */
@Slf4j
@CompileStatic
class Type1FontMetrics extends DefaultTask {

    @Input
    @Option(option = 'fontFile', description = 'Path of the TrueType font (.ttf) or font collection (.ttc) file')
    final Property<String> fontFile = project.objects.property(String)

    @Input
    @Option(option = 'metricsFileName', description = 'Filename of the metrics file to create (it will be created in the build directory)')
    final Property<String> metricsFileName = project.objects.property(String)

    @Input
    @Optional
    @Option(option = 'fontName', description = 'default is to use the fontname in the .pfm file, but you can override that name to make sure that the embedded font is used (if you\'re embedding fonts) instead of installed fonts when viewing documents with Acrobat Reader.')
    final Property<String> fontName = project.objects.property(String)

    @OutputFile
    final Provider<RegularFile> metricsFile = project.layout.buildDirectory.file(metricsFileName)

    @TaskAction
    void generateFontMetrics() {
        // This code is derived from PFMReader.main()
        log.info('Parsing font...')
        def app = new PFMReader()
        def pfm = app.loadPFM(fontFile.get())
        if (pfm != null) {
            app.preview(pfm)
            def doc = app.constructFontXML(pfm, fontName.getOrNull(), null, null, null)
            app.writeFontXML(doc, metricsFile.get().asFile)
            log.info("XML font metrics file successfully created.");
        }
    }
}
