@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0
:begin

CLS
ECHO a. AntRunner/xPath     
ECHO s. Watch css
ECHO d. Timer
ECHO f. Open ContentURL

CHOICE /C asdfbwt /CS /N /M "Pick a task: "
IF [%ERRORLEVEL%] == [1] START antRunner.bat
IF [%ERRORLEVEL%] == [2] CALL copyLocal.bat
IF [%ERRORLEVEL%] == [3] START Timer.bat
IF [%ERRORLEVEL%] == [4] CALL ContentUrl.bat
IF [%ERRORLEVEL%] == [5] START runForDev.bat
IF [%ERRORLEVEL%] == [6] START csswatch.bat
IF [%ERRORLEVEL%] == [7] GOTO tomcat
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

