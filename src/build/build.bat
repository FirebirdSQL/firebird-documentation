@echo off
rem ----- Verify and Set Required Environment Variables -----------------------
if not "%JAVA_HOME%" == "" goto gotJavaHome
echo You must set JAVA_HOME to point at your JDK or JRE distribution
goto exit

:gotJavaHome
set _CP_=

rem ----- ant libraries ------
set _CP_=..\..\lib\ant.jar
set _CP_=%_CP_%;..\..\lib\optional.jar

rem ----- saxon libraries ------
set _CP_=%_CP_%;..\..\lib\saxon.jar

rem ----- fop libraries ------
set _CP_=%_CP_%;..\..\lib\fop.jar
set _CP_=%_CP_%;..\..\lib\batik.jar
set _CP_=%_CP_%;..\..\lib\avalon-framework.jar

set _CP_=%_CP_%;..\..\lib

"%JAVA_HOME%\bin\java.exe" -showversion -Xmx100000000 -classpath "%JAVA_HOME%\lib\tools.jar;%_CP_%;%CLASSPATH%" org.apache.tools.ant.Main %1 %2 %3
rem -Xbootclasspath/p:d:/Work/Firebird/manual/lib

:exit
