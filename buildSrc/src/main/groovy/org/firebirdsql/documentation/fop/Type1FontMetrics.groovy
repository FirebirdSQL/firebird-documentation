package org.firebirdsql.documentation.fop

import org.gradle.api.tasks.TaskAction

import groovy.transform.CompileStatic
import groovy.util.logging.Slf4j
import org.apache.fop.fonts.apps.PFMReader

/**
 * Produces font metrics for Adobe Type 1 Fonts in .pfm files.
 */
@Slf4j
@CompileStatic
class Type1FontMetrics extends AbstractFontMetrics {

    Type1FontMetrics() {
        description = 'Generates a Type 1 font metrics file'
    }

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
            log.info("XML font metrics file successfully created.")
        }
    }
}
