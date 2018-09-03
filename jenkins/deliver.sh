#!/usr/bin/env bash

echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'
set -x
mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'The following complex command extracts the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
set -x
NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
set +x

echo 'The following complex command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'
set -x
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
set +x

#echo 'The following command runs and outputs the execution of your Java'
#echo 'application (which Jenkins built using Maven) to the Jenkins UI.'
#set -x
#/usr/bin/java -jar target/${NAME}-${VERSION}.war

sudo rm -f /var/lib/tomcat7/webapps/java-hello-world-1.1.war
sudo rm -rf /var/lib/tomcat7/webapps/java-hello-world-1.1
#rm -f /var/lib/tomcat7/webapps/java-hello-world-1.1.war
#rm -rf /var/lib/tomcat7/webapps/java-hello-world-1.1
sleep 5
ls -lrth /var/lib/tomcat7/webapps
cp -r /var/lib/jenkins/workspace/Pipeline-java-war/target/java-hello-world-1.1.war /var/lib/tomcat7/webapps/
sleep 5
sudo service tomcat7 restart
echo "Tomcat restarted"

curl -v http://34.239.123.227:8081/java-hello-world-1.1/hello



