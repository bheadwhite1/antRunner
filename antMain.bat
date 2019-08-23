@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0
:begin

CLS
ECHO a. AntRunner/xPath    t. Toggle Tomcat 
ECHO s. Watch css
ECHO d. Timer
ECHO f. Open ContentURL

CHOICE /C asdft /CS /N /M "Pick a task: "
IF [%ERRORLEVEL%] == [1] START antRunner.bat
IF [%ERRORLEVEL%] == [2] START csswatch.bat
IF [%ERRORLEVEL%] == [3] START Timer.bat
IF [%ERRORLEVEL%] == [4] CALL ContentUrl.bat
IF [%ERRORLEVEL%] == [5] GOTO tomcat
GOTO begin

:tomcat
sc query tomcat8 | findstr RUNNING > NUL
IF ERRORLEVEL 1 (
    net start tomcat8
) ELSE ( 
    net stop tomcat8
)
pause
GOTO begin

