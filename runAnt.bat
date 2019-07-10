@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0
MODE con:lines=1000
SET "techuserDir=C:\git\skywest-techuser"
CALL ant "-DinputManual=%~1" -buildfile !techuserDir!\doctypes\\%2\transform\apache.ant "%~3"
START /b "" CSCRIPT alert.vbs "%~1 runner is complete" "%~1"
pause
EXIT