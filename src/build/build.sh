#! /bin/sh

if [ "$JAVA_HOME" == "" ] ; then
  echo "    Error: The JAVA_HOME environment variable is not set."
  echo "    You must set it to point at your JDK or JRE distribution,"
  echo "    e.g. JAVA_HOME=/usr/java/j2sdk"
  exit 1
fi


# set up the classpath _CP_ :

# ----- ant libraries: ------
_CP_=../../lib/ant.jar
_CP_=$_CP_:../../lib/optional.jar

# ----- saxon libraries: ------
_CP_=$_CP_:../../lib/saxon.jar

# ----- FOP libraries: ------
_CP_=$_CP_:../../lib/fop.jar
_CP_=$_CP_:../../lib/batik.jar
_CP_=$_CP_:../../lib/avalon-framework.jar

# ----- graphics libraries used by FOP ------
_CP_=$_CP_:../../lib/jimi_1.0.jar
_CP_=$_CP_:../../lib/jai_core.jar
_CP_=$_CP_:../../lib/jai_codec.jar

_CP_=$_CP_:../../lib

_CP_=$_CP_:$JAVA_HOME/lib/tools.jar:$CLASSPATH

"$JAVA_HOME/bin/java" -Xmx100000000 -showversion -classpath "$_CP_" org.apache.tools.ant.Main $*

