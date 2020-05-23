package org.firebirdsql.documentation.asciidoc

import org.gradle.api.file.DirectoryProperty
import org.gradle.api.model.ObjectFactory
import org.gradle.api.provider.Property

class AsciidocConfig {

    final DirectoryProperty sourceDir
    final DirectoryProperty outputDir
    final DirectoryProperty themeDir
    final Property<String> htmlTheme
    final Property<String> pdfTheme

    AsciidocConfig(ObjectFactory objectFactory) {
        sourceDir = objectFactory.directoryProperty()
        outputDir = objectFactory.directoryProperty()
        themeDir = objectFactory.directoryProperty().convention(sourceDir.dir('../../theme'))
        htmlTheme = objectFactory.property(String).convention('firebird-html')
        pdfTheme = objectFactory.property(String).convention('firebird-pdf')
    }

}
