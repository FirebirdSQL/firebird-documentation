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
import org.apache.fop.fonts.apps.TTFReader

/**
 * Produces font metrics for TrueType Fonts in .ttf or .ttc (font collection) files.
 */
@Slf4j
@CompileStatic
class TrueTypeFontMetrics extends DefaultTask {

    @Input
    @Option(option = 'fontFile', description = 'Path of the TrueType font (.ttf) or font collection (.ttc) file')
    final Property<String> fontFile = project.objects.property(String)

    @Input
    @Option(option = 'metricsFileName', description = 'Filename of the metrics file to create (it will be created in the build directory)')
    final Property<String> metricsFileName = project.objects.property(String)

    @Input
    @Optional
    @Option(option = 'ttcName', description = 'If you\'re reading data from a TrueType Collection (.ttc file) you must specify which font from the collection you will read metrics from. If you read from a .ttc file without this option, the fontnames will be listed for you when specifying --info.')
    final Property<String> ttcName = project.objects.property(String)

    @Input
    @Optional
    @Option(option = 'fontName', description = 'default is to use the fontname in the .ttf file, but you can override that name to make sure that the embedded font is used (if you\'re embedding fonts) instead of installed fonts when viewing documents with Acrobat Reader.')
    final Property<String> fontName = project.objects.property(String)

    @OutputFile
    final Provider<RegularFile> metricsFile = project.layout.buildDirectory.file(metricsFileName)

    @TaskAction
    void generateFontMetrics() {
        // This code is derived from TTFReader.main()
        log.info('Parsing font...')
        def app = new TTFReader()
        def ttf = app.loadTTF(fontFile.get(), ttcName.getOrNull(), true, true)
        if (ttf != null) {
            def doc = app.constructFontXML(ttf, fontName.getOrNull(), null, null, null, true, ttcName.getOrNull())

            log.info('Creating CID encoded metrics...')

            if (doc != null) {
                app.writeFontXML(doc, metricsFile.get().asFile)
            }

            if (ttf.isEmbeddable()) {
                log.info('This font contains no embedding license restrictions.')
            } else {
                log.info('** Note: This font contains license restrictions for embedding. This font shouldn\'t be embedded.')
            }
        }
        log.info('')
        log.info('XML font metrics file successfully created.')
    }
}
