@if (@CodeSection == @Batch) @then

@ECHO off
SETLOCAL enabledelayedexpansion

SET "getclip=cscript /nologo /e:JScript "%~f0""

FOR /F "tokens=*" %%F IN ('%getclip%') DO (
    SET booyeah="%%F"
)


FOR /F "TOKENS=2* delims=/" %%I IN (%booyeah%) DO SET "env=%%I"
FOR /F "TOKENS=3* delims==" %%I IN (%booyeah%) DO SET "contentPath=%%I"
FOR /F "TOKENS=7* delims=/" %%I IN ("%contentPath%") DO SET "last=%%I"
FOR /F "TOKENS=8* delims=/" %%I IN ("%contentPath%") DO SET "last=%%I"
FOR /F "TOKENS=9* delims=/" %%I IN ("%contentPath%") DO SET "last=%%I"

::1stFile
FOR /F "TOKENS=1-7 delims=/" %%A IN ("%contentPath%") DO SET "firstPath=%%A/%%B/%%C/%%D/%%E/%%F"
::2ndFile
FOR /F "TOKENS=1-7 delims=/" %%A IN ("%contentPath%") DO SET "secondPath=%%A/%%B/%%C/%%D/%%E/%%G"
::3rdFile
FOR /F "TOKENS=1-8 delims=/" %%A IN ("%contentPath%") DO SET "thirdPath=%%A/%%B/%%C/%%D/%%E/%%H"
::4thFile
FOR /F "TOKENS=1-9 delims=/" %%A IN ("%contentPath%") DO SET "fourthPath=%%A/%%B/%%C/%%D/%%E/%%I"
::lastFile
FOR /F "TOKENS=1-7 delims=/" %%A IN ("%contentPath%") DO SET "lastFile=%%A/%%B/%%C/%%D/%%E/!last!"


IF '%env%'=='localhost:8080' (
    START "C:\Program Files\firstobject\foxe.exe" "C:\techuser\data\!lastFile!.xml"
)
IF '%env%'=='sgutviewdevstage01' (
    START "C:\Program Files\firstobject\foxe.exe" "\\sgutviewdevstage01\e$\techuser\data\!lastFile!.xml"
)
IF '%env%'=='sgutviewdevqa01' (
    START "C:\Program Files\firstobject\foxe.exe" "\\sgutviewdevqa01\e$\techuser\data\!lastFile!.xml"
)
IF '%env%'=='sgutviewstage01' (
    START "C:\Program Files\firstobject\foxe.exe" "\\sgutviewstage01\e$\techuser\data\!lastFile!.xml"
)

IF '%env%'=='sgutviewqa01' (
    START "C:\Program Files\firstobject\foxe.exe" "\\sgutviewqa01\e$\techuser\data\!lastFile!.xml"
)
IF '%env%'=='techview.skywestonline.com' (
    START "C:\Program Files\firstobject\foxe.exe" "\\skywest.com\oo\Publications\TechView\techuser\data\!lastFile!.xml"
)

::GRABS THE CONTENT FULL PATH
ECHO env: %env%
REM ECHO fullpath: %contentPath%
REM ECHO last: %last%
REM ECHO 1stPath: %firstPath%
REM ECHO 2ndPath: %secondPath%
REM ECHO 3rdPath: %thirdPath%
REM ECHO 4thPath: %fourthPath%

@end
WSH.Echo(WSH.CreateObject('htmlfile').parentWindow.clipboardData.getData('text'));