#! /bin/sh

# ----- ant libraries ------
TARGET_CLASSPATH=../../lib/ant.jar:\
../../lib/optional.jar:\
# ----- saxon libraries ------
../../lib/saxon.jar:\
# ----- fop libraries ------
../../lib/fop.jar:\
../../lib/batik.jar:\
../../lib/avalon-framework-cvs-20020315.jar:\
../../lib

if [ "$JAVA_HOME" != "" ] ; then
   TARGET_CLASSPATH=$TARGET_CLASSPATH:$JAVA_HOME/lib/tools.jar
else
   echo "Error: The JAVA_HOME environment variable is not set."
fi

java -Xmx100000000 -showversion -classpath $TARGET_CLASSPATH org.apache.tools.ant.Main $*