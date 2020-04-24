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
import org.gradle.api.tasks.options.Option

import groovy.transform.CompileStatic
import groovy.util.logging.Slf4j

@CompileStatic
@Slf4j
abstract class AbstractFontMetrics extends DefaultTask {

    @Input
    @Option(option = 'fontFile', description = 'Path of the font file')
    final Property<String> fontFile = project.objects.property(String)

    @Input
    @Option(option = 'metricsFileName', description = 'Filename of the metrics file to create (it will be created in the build/font-metrics directory)')
    final Property<String> metricsFileName = project.objects.property(String)

    @Input
    @Optional
    @Option(option = 'fontName', description = 'default is to use the fontname in the font file, but you can override that name to make sure that the embedded font is used (if you\'re embedding fonts) instead of installed fonts when viewing documents with Acrobat Reader.')
    final Property<String> fontName = project.objects.property(String)

    @OutputFile
    final Provider<RegularFile> metricsFile = project.layout.buildDirectory.file(metricsFileName
            .map({ metricsFileName -> "font-metrics/${metricsFileName}" }))

    AbstractFontMetrics() {
        group = "fonts"
    }

}
