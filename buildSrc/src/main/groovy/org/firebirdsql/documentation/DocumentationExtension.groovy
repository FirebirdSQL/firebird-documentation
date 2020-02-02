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

import org.gradle.api.Project
import org.gradle.api.file.Directory
import org.gradle.api.file.DirectoryProperty
import org.gradle.api.file.FileTree
import org.gradle.api.provider.Property
import org.gradle.api.provider.Provider

class DocumentationExtension {
    
    // TODO Some documentation might be better moved to the build.gradle file

    private static final String FIREBIRDDOCS = "firebirddocs"

    final Project project
    final DirectoryProperty configRootDir
    final DirectoryProperty styleDir
    final DirectoryProperty docRoot
    final DirectoryProperty outputRoot
    /**
     * 'baseName' is the base setname, without language suffix.
     * <p>
     * Currently it can be firebirddocs (default), rlsnotes, papers or refdocs.
     * You can specify a base name on the command line like this:
     * <p>
     * <p>
     * .. TODO update for gradle build pdf -DbaseName=rlsnotes
     * </p>
     * <p>
     * A command-line baseName will override the value specified below.
     * </p>
     */
    final Property<String> baseName
    /**
     * Set the sfx (suffix) property to build another set than the default English docset.
     * E.g. with sfx=fr, firebirddocs-fr.xml will be rendered; with sfx=ru, firebirddcos-ru.xml, etc.
     * <p>
     * You can specify a sfx on the command line like this:
     * </p>
     * <p>
     * .. TODO update for gradle build html -Dsfx=fr
     * </p>
     * A command-line sfx will override the value specified below.
     * <p>
     */
    final Property<String> sfx
    /**
     * Set the 'rootId' property if you only want to build a certain doc or subtree.
     * E.g. "qsg15" for the Firebird 1.5 Quick Start Guide.
     * <p>
     * You can also specify it on the command line, like this:
     * </p>
     * <p>
     * .. TODO update for gradle build build pdf -Did=qsg15
     * </p>
     * <p>
     * A command-line id will override the value specified below.
     * </p>
     */
    final Property<String> rootId

    final Provider<Directory> configDir
    /**
     * setName is the base filename of the set, without extension, but already including
     * the language suffix (if applicable), e.g. firebirddocs, firebirddocs-ru, firebirddocs-es.
     */
    final Provider<String> setName
    /**
     * docName is the base filename of the output document, without extension.
     */
    final Provider<String> docName
    /**
     * baseSfx is '' for the default firebirddocs basename, and '-&lt;basename&gt;' for any others.
     * <p>
     * It is currently used for two purposes:
     * <ul>
     * <li>The multifile html output is placed in dist/html&lt;basesfx&gt;, so the sets are not in
     * each other's way (and they don't overwrite each other's index.html). Examples:
     * <ul>
     * <li> rlsnotes htmls go into the dist/html-rlsnotes folder,</li>
     * <li> firebirddocs (=default) htmls into dist/html.</li>
     * </ul>
     * </li>
     * <li> For the fo, monohtml, and html targets, *if* a stylesheet src/docs/xsl/&lt;target&gt;&lt;basesfx&gt;.xsl
     * exists (e.g. fo-rlsnotes.xsl for the rlsnotes base set), then that stylesheet is used to build the target.
     * Otherwise, the default stylesheet for that target (e.g. fo.xsl) is used.</li>
     * </ul>
     * </p>
     */
    final Provider<String> baseSfx
    /**
     * Directory with the sources of the configured set
     */
    final Provider<Directory> setSource

    final Provider<FileTree> imageSource

    DocumentationExtension(Project project) {
        this.project = project
        configRootDir = project.objects.directoryProperty()
        styleDir = project.objects.directoryProperty()
        docRoot = project.objects.directoryProperty()
        outputRoot = project.objects.directoryProperty()
        baseName = project.objects.property(String.class)
        baseName.set(FIREBIRDDOCS)
        sfx = project.objects.property(String.class)
        rootId = project.objects.property(String.class)

        configDir = configRootDir.<Directory>map { Directory configDirValue ->
            if (sfx.getOrElse('') != '') {
                return configDirValue.dir(sfx)
            }
            return configDirValue
        }
        setName = baseName.<String>map { String baseNameValue ->
            return deriveSetName(baseNameValue)
        }
        docName = baseName.<String>map { String baseNameValue ->
            if (rootId.getOrElse('') != '') {
                return rootId
            }
            return deriveSetName(baseNameValue)
        }
        baseSfx = baseName.<String>map { String baseNameValue ->
            if (baseNameValue == FIREBIRDDOCS) {
                return ''
            }
            return "-${baseNameValue}"
        }
        setSource = docRoot.<Directory>map { Directory docRootValue ->
            if (baseName.orNull == FIREBIRDDOCS) {
                return docRootValue
            }
            return docRootValue.dir(baseName)
        }
        imageSource = project.provider {
            return project.fileTree(docRoot.dir('images')) +
                    project.fileTree(docRoot.dir(baseName.map {baseNameValue -> "$baseNameValue/images" })) +
                    project.fileTree(docRoot.dir(setName.map {setNameValue -> "$setNameValue/images" }))
        }
    }

    String deriveSetName(String baseNameValue) {
        if (sfx.getOrElse('') != '') {
            return "${baseNameValue}-${sfx}"
        }
        return baseNameValue
    }

}
