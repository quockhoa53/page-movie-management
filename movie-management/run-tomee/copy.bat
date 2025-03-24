@echo off
echo Building project...
cd ..
copy /Y "target\HelloEJB-1.0-SNAPSHOT.war" "..\apache-tomee-webprofile-10.0.0\webapps\HelloEJB.war"