#! /bin/sh
 
# $Id$
  
TARGET_CLASSPATH=../../lib/ant.jar:\
../../lib/optional.jar:\
../../lib/NetComponents.jar:\
../../lib/parser.jar:\
../../lib/jaxp.jar:\
../../lib/xerces.jar:\
../../lib/bsf.jar:\
../../lib/xalan.jar:\
../../lib/fop.jar:\
../../lib/w3c.jar:\
../../lib

FIREBIRD_HOME=../../../client/java/src/
   
if [ "$JAVA_HOME" != "" ] ; then
   TARGET_CLASSPATH=$TARGET_CLASSPATH:$JAVA_HOME/lib/tools.jar
else
   echo "Error: The JAVA_HOME environment variable is not set."
fi
            
java -Xmx100000000 -classpath $TARGET_CLASSPATH -Dfirebird.home=$FIREBIRD_HOME org.apache.tools.ant.Main $*
