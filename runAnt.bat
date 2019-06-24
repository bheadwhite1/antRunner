@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0
MODE con:lines=1000

CALL ant "-DinputManual=%~1" -buildfile C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\\%2\transform\apache.ant "%~3"
START /b "" CSCRIPT alert.vbs "%~1 runner is complete" "%~1"