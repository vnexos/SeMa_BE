#!/bin/bash

# Build project
./mvnw clean package -Dfile.encoding=UTF-8 -e

# Get the current project folder path
PROJECT_FOLDER=$(pwd)

# Set the Tomcat folder path
CATALINA_HOME="/d/apache-tomcat-11.0.5"

# Copy files (Note: Windows-style D:\ path is converted to Unix-style)
cp "${PROJECT_FOLDER}/webapp/target/ROOT.war" "${CATALINA_HOME}/webapps/"
cp "${PROJECT_FOLDER}/modules/language/target/language.jar" "${CATALINA_HOME}/webapps/modules/"

# Run Tomcat
"${CATALINA_HOME}/bin/catalina.sh" run -Dcatalina.base="${PROJECT_FOLDER}" -Dcatalina.home="${CATALINA_HOME}"