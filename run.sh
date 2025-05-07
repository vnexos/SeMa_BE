#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build project
./mvnw clean package -Dfile.encoding=UTF-8 -e

# Get the current project folder path
PROJECT_FOLDER=$(pwd)

# Set the Tomcat folder path
CATALINA_HOME="/opt/apache-tomcat-11.0.5"

# Ensure the modules directory exists
mkdir -p "$CATALINA_HOME/webapps/modules"

# Copy ROOT.war to Tomcat webapps
cp "$PROJECT_FOLDER/core/target/ROOT.war" "$CATALINA_HOME/webapps/"

# Copy all JARs from modules/target directories to Tomcat modules folder
find "$PROJECT_FOLDER/modules" -type f -path "*/target/*.jar" -exec cp {} "$CATALINA_HOME/webapps/modules/" \;

# Run Tomcat
"$CATALINA_HOME/bin/catalina.sh" run -Dcatalina.base="$PROJECT_FOLDER" -Dcatalina.home="$CATALINA_HOME"
