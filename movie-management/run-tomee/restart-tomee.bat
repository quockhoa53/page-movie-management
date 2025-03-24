@echo off
echo Restarting TomEE...
cd "..\..\apache-tomee-webprofile-10.0.0\bin"
call shutdown.bat
timeout /t 2
call startup.bat

echo Deployment complete!
pause