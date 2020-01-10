This is the manual/lib folder.

To get the library jars needed to build the documentation, go to

  https://www.firebirdsql.org/doclibs/

and download either all the JAR files or ALLJARS.ZIP. If you've
downloaded ALLJARS.ZIP, unzip it here. Don't use "Unzip to..."
because that may create a subfolder and make the jars untraceable
for the build program.

LATEST (26 September 2011):
      xercesImpl.jar has been added to the libraries. We need
      this to be able to use xincludes.
      You can download xercesImpl.jar separately from the server
      or download and unzip the latest ALLJARS.ZIP

OLDER NOTES:
    - Tools.jar has been left out of ALLJARS.ZIP because it's
      rather big and not everybody needs it. Download it only if
      your PDF builds fail with a message about tools.jar not
      being found.

    - If you have downloaded ALLJARS.ZIP, look at the timestamps
      of the JAR files on the server. If some JARs are newer than
      ALLJARS.ZIP, download them and install them over the versions
      extracted from the ZIP.

    - If you still find the file "optional.jar" in the lib folder,
      delete it!

Don't forget: you may also need to download files for manual/tools.
Look at the readme there.



Linux shortcut
--------------

On Linux, instead of visiting the site with a browser, you can cd
to the manual/lib folder and type at the command prompt:

  $ wget https://www.firebirdsql.org/doclibs/ALLJARS.ZIP
  $ unzip ALLJARS.ZIP

This will download and unzip the Java libraries for you.
