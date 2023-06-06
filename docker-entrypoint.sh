#!/bin/sh

echo "*************************************************************************************"
echo "*********** Starting Application *****************"
echo "*************************************************************************************"
java -Djava.security.egd=file:/dev/./urandom -javaagent:/app/apm-agent.jar -Delastic.apm.log_format_sout=JSON -jar /app/app.jar
