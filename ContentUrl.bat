@if (@CodeSection == @Batch) @then

@ECHO off
SETLOCAL enabledelayedexpansion
SET "foxeExe=C:\Program Files\firstobject\foxe.exe"
SET "getclip=cscript /nologo /e:JScript "%~f0""

FOR /F "tokens=*" %%F IN ('%getclip%') DO (
    SET booyeah="%%F"
)

FOR /F "TOKENS=2* delims=/" %%I IN (%booyeah%) DO SET "env=%%I"
FOR /F "TOKENS=3* delims==" %%I IN (%booyeah%) DO SET "contentPath=%%I"
FOR /F "TOKENS=6* delims=/" %%I IN ("%contentPath%") DO SET "last=%%I"
FOR /F "TOKENS=7* delims=/" %%I IN ("%contentPath%") DO SET "last=%%I"
FOR /F "TOKENS=8* delims=/" %%I IN ("%contentPath%") DO SET "last=%%I"
FOR /F "TOKENS=9* delims=/" %%I IN ("%contentPath%") DO SET "last=%%I"

REM ::1stFile
REM FOR /F "TOKENS=1-6 delims=/" %%A IN ("%contentPath%") DO SET "firstPath=%%A/%%B/%%C/%%D/%%E/%%F"
REM ::2ndFile
REM FOR /F "TOKENS=1-7 delims=/" %%A IN ("%contentPath%") DO SET "firstPath=%%A/%%B/%%C/%%D/%%E/%%F"
REM ::3rdFile
REM FOR /F "TOKENS=1-7 delims=/" %%A IN ("%contentPath%") DO SET "secondPath=%%A/%%B/%%C/%%D/%%E/%%G"
REM ::4thFile
REM FOR /F "TOKENS=1-8 delims=/" %%A IN ("%contentPath%") DO SET "thirdPath=%%A/%%B/%%C/%%D/%%E/%%H"
REM ::lastFile
REM FOR /F "TOKENS=1-9 delims=/" %%A IN ("%contentPath%") DO SET "fourthPath=%%A/%%B/%%C/%%D/%%E/%%I"
FOR /F "TOKENS=1-7 delims=/" %%A IN ("%contentPath%") DO SET "lastFile=%%A\%%B\%%C\%%D\%%E\!last!"

REM debugging
REM ECHO file: !lastFile! env: %env%
IF '%env%'=='localhost:8080' (
    START "!foxeExe!" "C:\techuser\data\!lastFile!.xml"
)
IF '%env%'=='sgutviewdevstage01.skywest.com' (
    START "!foxeExe!" "\\sgutviewdevstage01\e$\techuser\data\!lastFile!.xml"
)
IF '%env%'=='sgutviewdevqa01.skywest.com' (
    START "!foxeExe!" "\\sgutviewdevqa01\e$\techuser\data\!lastFile!.xml"
)
IF '%env%'=='sgutviewstage01.skywest.com' (
    START "!foxeExe!" "\\sgutviewstage01\e$\techuser\data\!lastFile!.xml"
)
IF '%env%'=='sgutviewqa01.skywest.com' (
    START "!foxeExe!" "\\sgutviewqa01\e$\techuser\data\!lastFile!.xml"
)
IF '%env%'=='techview.skywestonline.com' (
    START "!foxeExe!" "\\skywest.com\oo\Publications\TechView\techuser\data\!lastFile!.xml"
)

::GRABS THE CONTENT FULL PATH
ECHO env: %env%
REM echo !lastFile!
REM pause
REM ECHO fullpath: %contentPath%
REM ECHO last: %last%
REM ECHO 1stPath: %firstPath%
REM ECHO 2ndPath: %secondPath%
REM ECHO 3rdPath: %thirdPath%
REM ECHO 4thPath: %fourthPath%

@end
WSH.Echo(WSH.CreateObject('htmlfile').parentWindow.clipboardData.getData('text'));