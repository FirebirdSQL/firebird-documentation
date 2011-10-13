#! /bin/sh

if [ "$JAVA_HOME" == "" ] ; then
  echo "    Error: The JAVA_HOME environment variable is not set."
  echo "    It must point at your JDK or JRE distribution, e.g.:"
  echo "      JAVA_HOME=/usr/java/j2sdk"
  exit 1
fi


cp=../../lib/ant-launcher.jar
class=org.apache.tools.ant.launch.Launcher

"$JAVA_HOME/bin/java" -showversion -Xmx300000000 -classpath $cp -Dant.home=../.. $class $*
