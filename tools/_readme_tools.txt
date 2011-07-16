This is the manual/tools folder.

To get the external tools needed to build the documentation, go to

  http://www.firebirdsql.org/doctools/

and download any ZIP files you find there.
Unzip them right here; they will create their own subdirectories.
Don't use "Unzip to..." because this will often create an extra
directory level; if that happens, the tools won't be found by the
build program.

At this moment, the external tool archives are:
  docbook-dtd.zip           - the DocBook Document Type Definition
  docbook-stylesheets.zip   - the standard DocBook XSL stylesheets

NOTE: If you still have the "docbook" and "docbookx" subtrees in
      manual/src/docs, remove them completely!

Don't forget: you may also need to download files for manual/lib.
Look at the readme there.



Linux shortcut
--------------

On Linux, instead of visiting the site with a browser, you can cd
to the manual/tools folder and type at the command prompt:

  $ sh get_tools_linux.sh

This will download and unzip the tools for you.
