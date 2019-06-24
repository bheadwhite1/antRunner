@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0
:begin

CLS
ECHO a. AntRunner/xPath     b. Build for Dev
ECHO s. Copy script         w. Watch css
ECHO d. Timer
ECHO f. Open ContentURL

CHOICE /C asdfbw /CS /N /M "Pick a task: "


IF "%ERRORLEVEL%"== "1" START antRunner.bat
IF "%ERRORLEVEL%"== "2" START Copy.bat
IF "%ERRORLEVEL%"== "3" START Timer.bat
IF "%ERRORLEVEL%"== "4" CALL ContentUrl.bat
IF "%ERRORLEVEL%"== "5" START runForDev.bat
IF "%ERRORLEVEL%"== "6" START csswatch.bat
GOTO begin
