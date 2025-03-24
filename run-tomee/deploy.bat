@echo off
echo Building project...
cd ..
mvn clean package -DskipTests

echo Deploying WAR file...
copy /Y "target\HelloEJB-1.0-SNAPSHOT.war" "T\page-movie-management\apache-tomee-webprofile-10.0.0\webapps\"

echo Restarting TomEE...
cd /d "..\apache-tomee-webprofile-10.0.0\bin"
call shutdown.bat
timeout /t 5
call startup.bat

echo Deployment complete!
pause
