@echo off
rem ----- Verify and Set Required Environment Variables -----------------------
if not "%JAVA_HOME%" == "" goto gotJavaHome
echo *
echo *    Error: The JAVA_HOME environment variable is not set.
echo *    You must set it to point at your JDK or JRE distribution,
echo *    e.g. JAVA_HOME=C:\j2re1.4.2_06
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

rem ----- graphics libraries used by FOP ------
set _CP_=%_CP_%;..\..\lib\jimi_1.0.jar
set _CP_=%_CP_%;..\..\lib\jai_core.jar
set _CP_=%_CP_%;..\..\lib\jai_codec.jar

set _CP_=%_CP_%;..\..\lib

set _CP_=%_CP_%;%JAVA_HOME%\lib\tools.jar;%CLASSPATH%


"%JAVA_HOME%\bin\java.exe" -showversion -Xmx100000000 -classpath "%_CP_%" org.apache.tools.ant.Main %1 %2 %3 %4 %5


:exit

