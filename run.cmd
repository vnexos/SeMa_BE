@echo off
setlocal enabledelayedexpansion
REM Exit immediately if a command fails
set ERRLEV=0

REM Build project
call mvn clean package -Dfile.encoding=UTF-8 -e
if errorlevel 1 exit /b %errorlevel%

REM Get the current project folder path
set PROJECT_FOLDER=%cd%

REM Set the Tomcat folder path
set CATALINA_HOME=D:\apache-tomcat-11.0.5

copy "%PROJECT_FOLDER%\core\target\ROOT.war" "%CATALINA_HOME%\webapps"
if errorlevel 1 exit /b %errorlevel%

for /R "%PROJECT_FOLDER%\modules" %%f in (target\*.jar) do (
  copy "%%f" "%CATALINA_HOME%\webapps\modules\"
  if errorlevel 1 exit /b !errorlevel!
)

REM Run Tomcat
call "%CATALINA_HOME%\bin\catalina.bat" run -Dcatalina.base="%PROJECT_FOLDER%" -Dcatalina.home="%CATALINA_HOME%"
if errorlevel 1 exit /b %errorlevel%
