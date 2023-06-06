Firebird documentation
----------------------

After checking out the firebird-documentation repository, and if your
Java environment is set up correctly, open a command window and go to
the directory containing the firebird-documentation repository. Then
give one of these commands:

```
./gradlew                         [ Unix    ]
gradlew                           [ Windows ]
```

to get an overview of compilable targets.

If that worked, try e.g.:

```
./gradlew asciidocHtml             [ Unix    ]
gradlew asciidocHtml               [ Windows ]
```

to build the HTML version of the docs.
(Note: the HTML pages will wind up in build/docs/asciidoc/html/en/firebirddocs)

To build a specific document, or a document from another set, or another
language, you can specify:

````
gradlew asciidocHtml --docId=gbak
gradlew asciidocPdf --baseName=refdocs --docId=fblangref25
gradlew asciidocHtml --language=de
````

To get more information on a task, use

```
./gradlew help --task=asciidocHtml [ Unix    ]
gradlew help --task=asciidocHtml   [ Windows ]
```

Warning: if you build the asciidocPdf target, you might get some error
messages. Don't let that discourage you. Just look at the last
output lines: if it says BUILD SUCCESSFUL there, everything's fine.

The `docbookHtml` and `docbookPdf` tasks are available to build documentation
that has not been migrated to AsciiDoc. However, if you feel the need to build
those documents, it might be an indication they need to be migrated. Please
ask for guidance or help on the [firebird-devel list](https://groups.google.com/g/firebird-devel).

If you have any questions, *first* get the Docbuilding Howto at:

  https://www.firebirdsql.org/en/reference-manuals/

If your question isn't answered there, post a message to the Firebird
Development list. You can use this page to subscribe:

  https://groups.google.com/g/firebird-devel
