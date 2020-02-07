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
package org.firebirdsql.documentation.docbook

import javax.xml.transform.TransformerFactory
import javax.xml.transform.sax.SAXResult
import javax.xml.transform.stream.StreamSource

import groovy.transform.CompileStatic
import org.apache.fop.apps.FopFactoryBuilder
import org.apache.fop.apps.MimeConstants
import org.apache.fop.configuration.DefaultConfigurationBuilder

// Parts derived from https://github.com/spring-projects/spring-build-gradle

@CompileStatic
class DocbookFoPdf extends Docbook {

    DocbookFoPdf() {
        super('fo')
    }

    /**
     * <a href="http://xmlgraphics.apache.org/fop/0.95/embedding.html#render">From the FOP usage guide</a>
     */
    @Override
    protected void postTransform(File foFile) {
        super.postTransform(foFile)
        // TODO Make configurable
        def cfgBuilder = new DefaultConfigurationBuilder()
        def cfg = cfgBuilder.buildFromFile(project.file('config/fop-userconfig.xml'))
        def fopFactoryBuilder = new FopFactoryBuilder(docsOutput.get().asFile.toURI())
                .setConfiguration(cfg)
        def fopFactory = fopFactoryBuilder.build()
//        fopFactory.setUserConfig(project.file('config/fop-userconfig.xml'))

        final pdfFile = docsOutput.get().file("${setName.get()}.pdf").asFile
        logger.debug("Transforming 'fo' file $foFile to PDF: $pdfFile")

        new BufferedOutputStream(new FileOutputStream(pdfFile)).withCloseable { out ->
            def fop = fopFactory.newFop(MimeConstants.MIME_PDF, out)

            def factory = TransformerFactory.newInstance()
            def transformer = factory.newTransformer()

            def src = new StreamSource(foFile)
            def res = new SAXResult(fop.getDefaultHandler())
            
            transformer.transform(src, res)
        }

//        if (!foFile.delete()) {
//            logger.warn("Failed to delete 'fo' file " + foFile)
//        }
    }

}
