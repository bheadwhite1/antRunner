@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0
:begin

CLS
ECHO a. AntRunner/xPath     b. Build for Dev
ECHO s. Copy script         w. Watch css
ECHO d. Timer               t. Restart tomcat
ECHO f. Open ContentURL

CHOICE /C asdfbwt /CS /N /M "Pick a task: "


IF "%ERRORLEVEL%"== "1" START antRunner.bat
IF "%ERRORLEVEL%"== "2" START Copy.bat
IF "%ERRORLEVEL%"== "3" START Timer.bat
IF "%ERRORLEVEL%"== "4" CALL ContentUrl.bat
IF "%ERRORLEVEL%"== "5" START runForDev.bat
IF "%ERRORLEVEL%"== "6" START csswatch.bat
IF "%ERRORLEVEL%"== "7" GOTO tomcat
GOTO begin

:tomcat 
net stop tomcat8
IF ERRORLEVEL 1 ECHO this is stopped && PAUSE
net start tomcat8
PAUSE
GOTO begin

