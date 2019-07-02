@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0
:begin

CLS
ECHO a. AntRunner/xPath     b. Restart tomcat
ECHO s. Copy script         w. Watch css
ECHO d. Timer
ECHO f. Open ContentURL

CHOICE /C asdfbw /CS /N /M "Pick a task: "


IF "%ERRORLEVEL%"== "1" START antRunner.bat
IF "%ERRORLEVEL%"== "2" START Copy.bat
IF "%ERRORLEVEL%"== "3" START Timer.bat
IF "%ERRORLEVEL%"== "4" CALL ContentUrl.bat
IF "%ERRORLEVEL%"== "5" GOTO tomcat
IF "%ERRORLEVEL%"== "6" START csswatch.bat
GOTO begin

:tomcat 
CALL net stop tomcat8
IF ERRORLEVEL 1 ECHO this is stopped && PAUSE
CALL net start tomcat8
PAUSE
GOTO begin

