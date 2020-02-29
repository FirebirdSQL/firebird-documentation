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

import javax.xml.transform.TransformerFactory
import javax.xml.transform.sax.SAXResult
import javax.xml.transform.stream.StreamSource

import org.gradle.api.file.RegularFileProperty
import org.gradle.api.tasks.InputFile
import org.gradle.api.tasks.TaskAction

import groovy.transform.CompileStatic
import groovy.util.logging.Slf4j
import org.apache.fop.apps.FopFactoryBuilder
import org.apache.fop.apps.MimeConstants
import org.apache.fop.apps.io.ResourceResolverFactory
import org.apache.fop.configuration.DefaultConfigurationBuilder
import org.firebirdsql.documentation.AbstractTransformationTask

/**
 * Provides transformation from FO
 */
@CompileStatic
@Slf4j
class FoTask extends AbstractTransformationTask {

    @InputFile
    final RegularFileProperty inputFoFile = project.objects.fileProperty()

    FoTask() {
        super('pdf')
        outputTypeName.convention('pdf')
    }

    @TaskAction
    void transform() {
        final foFile = inputFoFile.get().asFile
        final pdfFile = docsOutput.get().file("${docName.get()}.${extension}").asFile

        def cfgBuilder = new DefaultConfigurationBuilder()
        def cfg = cfgBuilder.buildFromFile(languageConfigDir.get().file('fop-userconfig.xml').asFile)
        def fopFactoryBuilder = new FopFactoryBuilder(docsOutput.get().asFile.toURI())
                .setConfiguration(cfg)
                .setBaseURI(foFile.getParentFile().toURI())
        def fontManager = fopFactoryBuilder.getFontManager()
        fontManager.setResourceResolver(ResourceResolverFactory
                .createDefaultInternalResourceResolver(languageConfigDir.get().asFile.toURI()))
        def fopFactory = fopFactoryBuilder
                .build()

        logger.info("Transforming 'fo' file $foFile to PDF: $pdfFile")

        new BufferedOutputStream(new FileOutputStream(pdfFile)).withCloseable { out ->
            def fop = fopFactory.newFop(getMimeType(), out)

            def factory = TransformerFactory.newInstance()
            def transformer = factory.newTransformer()

            def src = new StreamSource(foFile)
            def res = new SAXResult(fop.getDefaultHandler())

            transformer.transform(src, res)
        }
    }

    private String getMimeType() {
        switch (outputTypeName.get()) {
            case 'pdf':
                return MimeConstants.MIME_PDF
            case 'at':
                return MimeConstants.MIME_FOP_AREA_TREE
            default:
                throw new IllegalArgumentException("Unsupported output type: ${outputTypeName.get()}")
        }
    }
    
}
