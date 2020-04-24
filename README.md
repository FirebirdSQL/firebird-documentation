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
./gradlew docbookHtml             [ Unix    ]
gradlew docbookHtml               [ Windows ]
```

to build the HTML version of the docs.
(Note: the HTML pages will wind up in build/html-firebirddocs)

To get more information on a task, use

```
./gradlew help --task=docbookHtml [ Unix    ]
gradlew help --task=docbookHtml   [ Windows ]
```

Warning: if you build the docbookPdf target, you will get lots of error
messages. Don't let that discourage you. Just look at the last
output lines: if it says BUILD SUCCESSFUL there, everything's fine.

If you have any questions, *first* get the Docbuilding Howto at:

  https://www.firebirdsql.org/en/reference-manuals/

If your question isn't answered there, post a message to the Firebird
docwriters' list. You can use this page to subscribe:

  https://lists.sourceforge.net/lists/listinfo/firebird-docs
