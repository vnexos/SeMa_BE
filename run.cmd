@echo off
REM Build project
call mvnw clean package -Dfile.encoding=UTF-8 -e

REM Get the current project folder path
set PROJECT_FOLDER=%cd%

REM Set the Tomcat folder path
set CATALINA_HOME=D:\apache-tomcat-11.0.5

copy "%PROJECT_FOLDER%\webapp\target\ROOT.war" "%CATALINA_HOME%\webapps"
for /R "%PROJECT_FOLDER%\modules" %%f in (target\*.jar) do (
  copy "%%f" "%CATALINA_HOME%\webapps\modules\"
)

REM Run Tomcat
call "%CATALINA_HOME%\bin\catalina.bat" run -Dcatalina.base="%PROJECT_FOLDER%" -Dcatalina.home="%CATALINA_HOME%"