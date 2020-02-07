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
package org.firebirdsql.documentation

import org.gradle.api.Action
import org.gradle.api.NamedDomainObjectFactory
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.api.Task

import groovy.transform.CompileStatic
import org.firebirdsql.documentation.docbook.Docbook

@CompileStatic
@SuppressWarnings("unused")
class DocumentationPlugin implements Plugin<Project> {

    static final String DOCUMENTATION_EXTENSION = "docConfig"
    static final String DOCUMENTATION_OUTPUT_TYPES = "docOutputTypes"
    static final String DOCUMENTATION_SET_CONTAINER = "documentationSets"

    @Override
    void apply(Project project) {
        project.apply(plugin: 'base')

        def extension = project.extensions.create(DOCUMENTATION_EXTENSION, DocConfigExtension, project.objects)
        project.tasks.withType(Docbook).whenTaskAdded { Docbook task ->
            task.configureWith(extension)
        }

        def docOutputTypes = project.container(DocOutputType, new NamedDomainObjectFactory<DocOutputType>() {
            @Override
            DocOutputType create(String name) {
                return new DocOutputType(name, project.getObjects())
            }
        })
        project.getExtensions().add(DOCUMENTATION_OUTPUT_TYPES, docOutputTypes)

        def documentationSetsContainer = project.container(DocumentationSet, new NamedDomainObjectFactory<DocumentationSet>() {
            @Override
            DocumentationSet create(String name) {
                return new DocumentationSet(name, project.getObjects())
            }
        })
        project.getExtensions().add(DOCUMENTATION_SET_CONTAINER, documentationSetsContainer)

        project.afterEvaluate {
            docOutputTypes.all { DocOutputType docOutputType ->
                String outputName = capitalizeFirst(docOutputType.name)
                documentationSetsContainer.all { DocumentationSet docSet ->
                    def taskName = "${docSet.name}${outputName}"
                    project.tasks.register(taskName, docOutputType.taskType.get(), new Action<Task>() {
                        @Override
                        void execute(Task task) {
                            task.group = 'documentation'
                            task.description = "Builds documentation for set ${docSet.name}, output type ${docOutputType.name}"
                            if (task instanceof Docbook) {
                                task.outputTypeName.set(docOutputType.name)
                                task.baseName.set(docSet.baseName)
                                task.stylesheetBaseName.set(docOutputType.stylesheetBaseName)
                                task.imageExcludes.set(docOutputType.imageExcludes)
                                task.extraFilesToOutput.set(docOutputType.extraFilesToOutput)
                            }
                        }
                    })
                }
            }
        }
    }

    private static String capitalizeFirst(String value) {
        if (value == null || value.length() == 0) {
            return ''
        }
        return value.substring(0, 1).toUpperCase() + value.substring(1)
    }
}
