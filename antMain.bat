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


IF "%ERRORLEVEL%"== "1" START antRunner.bat && GOTO begin
IF "%ERRORLEVEL%"== "2" START Copy.bat && GOTO begin
IF "%ERRORLEVEL%"== "3" START Timer.bat && GOTO begin
IF "%ERRORLEVEL%"== "4" CALL ContentUrl.bat && GOTO begin
IF "%ERRORLEVEL%"== "5" GOTO build
IF "%ERRORLEVEL%"== "6" start csswatch.bat
GOTO begin


:build
CLS
START ant -buildfile C:\Git\SkyWestAirlines\skywest-techuser-44\SkyWestBuild.ant [development]build_and_deploy_FOR_DEV
GOTO begin