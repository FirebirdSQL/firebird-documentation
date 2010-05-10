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

On unixes like linux 
$ cd tools 
$ wget http://www.firebirdsql.org/doctools/docbook-dtd.zip
$ wget http://www.firebirdsql.org/doctools/docbook-stylesheets.zip
$ unzip docbook-dtd.zip
$ unzip docbook-stylesheets.zip

or run the script (make shure you are in the tools dir)

$sh get_tools_linux.sh



