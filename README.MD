# SeMA - Module-oriented architecture for Java RestAPI
(This is my personal project, meaning it does not belong to my old company or my current University)

## Getting started
### Introduction
As the grow of a project, it become larger, more complexity, and harder to create a new feature or to maintain. And it may take much of time and effort to build and maintain.

### Installation
1. Clone a Git repository from Github
   ```bash
   git clone --recurse-submodules https://github.com/vnexos/SeMa_main.git
   ```
2. Setup the development environment by the path to the tomcat folder inside the `run.cmd` file (or `run.sh` file for linux)
   ```cmd
   REM Set the Tomcat folder path
   set CATALINA_HOME=D:\apache-tomcat-11.0.5
   ```
3. Run the project for the first time
   ```bash
   cd SeMa_main
   run
   ```
This command will build the project, copy target file to webapps folder inside tomcat and then run the tomcat.
## Project configuration
- The general settings for the project
  ```properties
  # the prefix of the API endpoint, the controller start with `/` will not be affected by the api prefix
  module.api-prefix=/api/v1
  # the folder contains all modules (`modules` is recommended)
  module.folder=modules
  # the development mode will allow the access from non-origin request like postman, ...
  module.development=true
  ```
- SQL settings
  ```properties
  # initialize the database at the startup of the server (recomment for development mode or running the server on production for the first time)
  sql.setup-on-start=true
  # The driver of database
  sql.driver=com.mysql.cj.jdbc.Driver
  # URL of database
  sql.url=jdbc:mysql://localhost:3306

  # Information of database 
  sql.db=vnexos
  sql.user=vnexos
  sql.pass=123123

  # Max allowed connection to database at the sametime
  sql.maxPoolSize=10
  ```
- Log settings
  ```properties
  # The folder contains log files (`logs` is recommended)
  log.folder=logs
  # The name of log file
  log.file=sema.log
  # The allowed log level for logging
  log.level=UNKNOWN|LOG|INFO|WARNING|ERROR|SQL|ROUTE

  # Show classpath in log line
  # 0 => Show nothing
  # 1 => Show only file (recommended)
  # 2 => Show function path only
  # 3 => Show both file and function path
  log.classpath=1

  log.show.brand=true
  # Show time in log line, `false` is not recommended
  log.show.time=true
  # Show log type in log line, `false` is not recommended
  log.show.type=true
  # Show module in log line, `false` is not recommended
  log.show.module=true
  ```
- CORS settings (use `*` for allowing all)
  ```properties
  # Allowed origins
  cors.origin=http://localhost:3000|http://localhost:3001
  # Allowed methods
  cors.method=GET|POST|PUT|PATCH|DELETE
  # Allowed headers
  cors.header=*
  # CORS Max age
  cors.max-age=3600
  # Allowing credentials
  cors.credentials=true
  ```
## Creating and setting up a module
1. Execute maven command to create a module (replace `<...>` with the value)
   ```bash
   ./mvnw archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DgroupId=<com.example.module> -DartifactId=<feature> -Dversion=<1.0> -Dpackage=<com.example.module.feature> -DparentGroupId=com.vnexos -DparentArtifactId=sema -DparentVersion=1.0 -DrelativePath=../../pom.xml -DoutputDirectory=modules/<feature>
   ```