#!/bin/bash

API_NAME="ETU003250"
BUILD_DIR="build"
LIB_DIR="lib"
SRC_DIR="src/main/java"
WEB_DIR="src/main/webapp"
TOMCAT_DIR="/media/matia/Bridge/tomcat-10.1.28/apache-tomcat-10.1.28/"
SERVLET_API_JAR="$LIB_DIR/servlet-api.jar"
WORKSPACE_DIR="/media/matia/Bridge/Projects/Java/Web/Servlet/Prevision/"

echo "Creating directories for build..."
mkdir -p "$BUILD_DIR/WEB-INF/classes"

echo "Java compiler version:"
javac -version

echo "Compiling Java source files with Java 17..."
find "$SRC_DIR" -name "*.java" > sources.txt
javac --release 17 -cp "$SERVLET_API_JAR" -d "$BUILD_DIR/WEB-INF/classes" @sources.txt
rm sources.txt

echo "Copying web application files to the build directory..."
cp -r "$WEB_DIR/." "$BUILD_DIR/"

echo "Generating the WAR file..."
cd "$BUILD_DIR" || exit
jar -cvf "../$API_NAME.war" *
cd ..

echo "Removing old deployment from Tomcat..."
if [ -d "$TOMCAT_DIR/webapps/$API_NAME" ]; then
  rm -rf "$TOMCAT_DIR/webapps/$API_NAME"
fi

echo "Deploying the new WAR file to Tomcat..."
cp "$API_NAME.war" "$TOMCAT_DIR/webapps/"

echo "Cleaning up generated WAR file..."
rm "$API_NAME.war"

echo "Returning to workspace..."
cd "$WORKSPACE_DIR" || exit

echo "Deployment complete!"
