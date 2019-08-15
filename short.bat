@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0
MODE con:lines=1000
SET "techuserDir=C:\git\skywest-techuser"
CALL ant "-DinputManual=%~1" "-Dpname=chapters" "-Dchapters=%~2" -f !techuserDir!\doctypes\\%3\transform\apache.ant %~4
START /b "" CSCRIPT alert.vbs "%~1" runner is complete" "%~1"
PAUSE