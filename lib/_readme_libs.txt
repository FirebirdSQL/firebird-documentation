This is the manual/lib folder.

To get the library jars needed to build the documentation, go to

  http://www.firebirdsql.org/doclibs/

and download either all the JAR files or ALLJARS.ZIP. If you've
downloaded ALLJARS.ZIP, unzip it here. Don't use "Unzip to..."
because that may create a subfolder and make the jars untraceable
for the build program.

NOTE: Tools.jar has been left out of ALLJARS.ZIP because it's
      rather big and not everybody needs it. Download it only if
      your PDF builds fail with a message about tools.jar not
      being found.

NOTE: If you have downloaded ALLJARS.ZIP, look at the timestamps
      of the JAR files on the server. If some JARs are newer than
      ALLJARS.ZIP, download them and install them over the versions
      extracted from the ZIP.

NOTE: If you still find the file "optional.jar" in the lib folder,
      delete it!

Don't forget: you may also need to download files for manual/tools.
Look at the readme there.
