@echo off
rem ----- Verify and Set Required Environment Variables -----------------------

if not "%JAVA_HOME%" == "" goto gotJavaHome
echo You must set JAVA_HOME to point at your Java Development Kit distribution
goto cleanup

:gotJavaHome

set _CP_=..\..\lib\ant.jar
set _CP_=%_CP_%;..\..\lib\optional.jar
set _CP_=%_CP_%;..\..\lib\NetComponents.jar
set _CP_=%_CP_%;..\..\lib\parser.jar
set _CP_=%_CP_%;..\..\lib\jaxp.jar
set _CP_=%_CP_%;..\..\lib\xalan.jar
set _CP_=%_CP_%;..\..\lib\xerces.jar
set _CP_=%_CP_%;..\..\lib\bsf.jar
set _CP_=%_CP_%;..\..\lib\fop.jar
set _CP_=%_CP_%;..\..\lib\w3c.jar
set _CP_=%_CP_%;..\..\lib

set FIREBIRD_HOME=..\..\..\client\java\src\

%JAVA_HOME%\bin\java.exe -Xmx100000000 -classpath "%JAVA_HOME%\lib\tools.jar;%_CP_%;%CLASSPATH%" -Dfirebird.home=%FIREBIRD_HOME% org.apache.tools.ant.Main %1 %2 %3 %4 %5


:cleanup
