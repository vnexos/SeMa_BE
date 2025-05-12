#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build project
mvn clean package -Dfile.encoding=UTF-8 -e

# Get the current project folder path
PROJECT_FOLDER="$(pwd)"

# Set the Tomcat folder path
CATALINA_HOME="/d/apache-tomcat-11.0.5"

# Copy ROOT.war to Tomcat's webapps
cp "$PROJECT_FOLDER/core/target/ROOT.war" "$CATALINA_HOME/webapps/"

# Ensure the target folder exists
mkdir -p "$CATALINA_HOME/webapps/modules"

# Copy all JARs from module targets to Tomcat's webapps/modules
find "$PROJECT_FOLDER/modules" -type f -path "*/target/*.jar" -exec cp {} "$CATALINA_HOME/webapps/modules/" \;

# Run Tomcat
"$CATALINA_HOME/bin/catalina.sh" run -Dcatalina.base="$PROJECT_FOLDER" -Dcatalina.home="$CATALINA_HOME"
