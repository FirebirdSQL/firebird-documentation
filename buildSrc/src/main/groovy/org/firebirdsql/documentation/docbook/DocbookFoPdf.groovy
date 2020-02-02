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

import javax.xml.transform.Result
import javax.xml.transform.Source
import javax.xml.transform.Transformer
import javax.xml.transform.TransformerFactory
import javax.xml.transform.sax.SAXResult
import javax.xml.transform.stream.StreamSource

import org.apache.fop.apps.Fop
import org.apache.fop.apps.FopFactory
import org.apache.fop.apps.FopFactoryBuilder
import org.apache.fop.apps.MimeConstants
import org.apache.fop.configuration.Configuration
import org.apache.fop.configuration.DefaultConfigurationBuilder

// Parts derived from https://github.com/spring-projects/spring-build-gradle

class DocbookFoPdf extends Docbook {

    /**
     * <a href="http://xmlgraphics.apache.org/fop/0.95/embedding.html#render">From the FOP usage guide</a>
     */
    @Override
    protected void postTransform(File foFile) {
        // TODO Make configurable
        DefaultConfigurationBuilder cfgBuilder = new DefaultConfigurationBuilder()
        Configuration cfg = cfgBuilder.buildFromFile(project.file('config/fop-userconfig.xml'))
        FopFactoryBuilder fopFactoryBuilder = new FopFactoryBuilder(docsOutput.get().asFile.toURI())
                .setConfiguration(cfg)
        FopFactory fopFactory = fopFactoryBuilder.build()
//        fopFactory.setUserConfig(project.file('config/fop-userconfig.xml'))

        final File pdfFile = getPdfOutputFile(foFile)
        logger.debug("Transforming 'fo' file $foFile to PDF: $pdfFile")

        new BufferedOutputStream(new FileOutputStream(pdfFile)).withCloseable { out ->
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, out)

            TransformerFactory factory = TransformerFactory.newInstance()
            Transformer transformer = factory.newTransformer()

            Source src = new StreamSource(foFile)
            Result res = new SAXResult(fop.getDefaultHandler())
            
            transformer.transform(src, res)
        }

//        if (!foFile.delete()) {
//            logger.warn("Failed to delete 'fo' file " + foFile)
//        }
    }

    private File getPdfOutputFile(File foFile) {
        return docsOutput.get().file(nameWithoutFileExtension(foFile) + '.pdf').asFile
    }
}
