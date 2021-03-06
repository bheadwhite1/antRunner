@ECHO off
SETLOCAL enabledelayedexpansion

SET /a Days=0
SET /a Hours=0
SET /a Minutes=0
SET /a Seconds=0
SET /a eDays=0
SET /a eHours=0
SET /a eMinutes=0
SET /a eSeconds=0
SET graphics=false
SET toDistribute=true
SET correctFile=
SET thisManual=
SET docFolder=

:pickTimer
MODE con: cols=48 lines=10

ECHO 1. PUBLISH and DISTRIBUTE to QA
ECHO 2. DISTRIBUTE to QA
ECHO 3. DISTRIBUTE to Live
ECHO.

CHOICE /C 123 /M "Pick a timer: "

IF ERRORLEVEL 1 SET "step=PUB"
IF ERRORLEVEL 2 SET "step=toQA"
IF ERRORLEVEL 3 SET "step=toLive"

CLS
ECHO 1. 175
ECHO 2. 200
ECHO 3. 700
ECHO 4. 900
ECHO.

CHOICE /C 1234 /M "Pick a fleet:"

IF ERRORLEVEL 1 SET fleet=175
IF ERRORLEVEL 2 SET fleet=200
IF ERRORLEVEL 3 SET fleet=700
IF ERRORLEVEL 4 SET fleet=900

CLS
ECHO 1. AMM
ECHO 2. MIP
ECHO 3. OTHER
ECHO.

CHOICE /C 123 /M "Pick a doctype:"

IF ERRORLEVEL 1 SET doctype=AMM
IF ERRORLEVEL 2 SET doctype=MIP
IF ERRORLEVEL 3 (
    SET /p doctype="What is the doctype name? "
    SET /p Hours="how long do you wanna wait in hours? "
    SET /p Minutes="minutes? "
    MODE con:cols=34 lines=3 
    SET titlebarMSG="%fleet% %doctype% Timer"
    SET timerMSG="%fleet% %doctype% Publishing should be complete, ready to begin toQA Timer"
    SET timerDisplay=!fleet! !doctype! !step!
    GOTO CountDown
)

:assigndata

SET timerDisplay=!fleet! !doctype! !step!
MODE con:cols=34 lines=3

IF '%step%'=='PUB' GOTO PUB
IF '%step%'=='toQA' GOTO toQA
IF '%step%'=='toLive' GOTO toLIVE
IF '%step%'=='GFXtoLive' GOTO GFX
IF '%step%'=='GFXtoQA' GOTO GFX
IF '%step%'=='toMX' GOTO toMX
IF '%step%'=='GFXtoMX' GOTO MGFX

:PUB
IF "%doctype%"=="MIP" (
    IF "%fleet%"=="900" SET Hours=1 && SET Minutes=28 && GOTO CountDown
    IF "%fleet%"=="700" SET Hours=1 && SET Minutes=28 && GOTO CountDown
    IF "%fleet%"=="200" SET Hours=1 && GOTO CountDown
    IF "%fleet%"=="175" SET Hours=1 && GOTO CountDown
    REM IF "%fleet%"=="175" SET Seconds=1 && GOTO CountDown
)
IF "%doctype%"=="AMM" (
    IF "%fleet%"=="900" ECHO nodata && GOTO end
    IF "%fleet%"=="700" ECHO nodata && GOTO end
    IF "%fleet%"=="200" ECHO nodata && GOTO end
    IF "%fleet%"=="175" SET Hours=4 && SET Minutes=30 && GOTO CountDown
)

:toQA
IF "%doctype%"=="MIP" (
    IF "%fleet%"=="900" SET Minutes=5 && GOTO CountDown
    IF "%fleet%"=="700" SET Minutes=5 && GOTO CountDown
    IF "%fleet%"=="200" SET Minutes=5 && GOTO CountDown
    IF "%fleet%"=="175" SET Minutes=5 && GOTO CountDown
    REM IF "%fleet%"=="175" SET Seconds=1 && GOTO CountDown
    )  
)
IF "%doctype%"=="AMM" (
    IF "%fleet%"=="900" ECHO nodata && GOTO end
    IF "%fleet%"=="700" ECHO nodata && GOTO end
    IF "%fleet%"=="200" ECHO nodata && GOTO end
    IF "%fleet%"=="175" SET Minutes=10 && GOTO CountDown
    )  
)

:toLIVE
SET MX=y
IF "%doctype%"=="MIP" (
    IF "%fleet%"=="900" SET Minutes=30 && GOTO CountDown
    IF "%fleet%"=="700" SET Minutes=30 && GOTO CountDown
    IF "%fleet%"=="200" SET Minutes=20 && GOTO CountDown
    IF "%fleet%"=="175" SET Minutes=27 && GOTO CountDown
    REM IF "%fleet%"=="175" SET Seconds=1 && GOTO CountDown
)
IF "%doctype%"=="AMM" (
    IF "%fleet%"=="900" ECHO nodata && GOTO end
    IF "%fleet%"=="700" ECHO nodata && GOTO end
    IF "%fleet%"=="200" ECHO nodata && GOTO end
    IF "%fleet%"=="175" SET Minutes=45 && GOTO CountDown
)
:GFX
SET Minutes=5 && GOTO CountDown
REM SET Seconds=5 && GOTO CountDown
:toMX
SET MX=
REM SET Seconds=5 && GOTO CountDown
SET Minutes=5 && GOTO CountDown
:MGFX
SET step=
REM SET Seconds=5 && GOTO CountDown
SET Minutes=5 && GOTO CountDown
:retry
SET "timerDisplay=%fleet%%doctype% %step% ++"
SET "retry=y"
SET Minutes=30 && GOTO CountDown
REM SET Seconds=1 && GOTO CountDown

MODE con:cols=34 lines=3
:CountDown
SET elapsedTime=%eHours%:%eMinutes%:%eSeconds%
CLS
ECHO [%Hours%:%Minutes%:%Seconds%][%elapsedTime%] %timerDisplay%
CHOICE /t 1 /c qn /cs /n /d n
IF NOT ERRORLEVEL 2 GOTO :popup
IF "%Seconds%"=="0" (
	IF "%Minutes%"=="0" (
		IF "%Hours%"=="0" (
			IF "%Days%"=="0" (

				GOTO popup
			)
			SET /a Days -=1
            SET Hours=24
		)
		SET /a Hours -=1
		SET Minutes=60
	)
	SET /a Minutes -=1
	SET Seconds=60
)

SET /a Seconds -=1

IF "%eSeconds%"=="59" (
	IF "%eMinutes%"=="59" (
		IF "%eHours%"=="23" (

			SET /a eDays +=1
			SET /a eHours=0
            GOTO Countdown
		)
		SET /a eHours +=1
		SET /a eMinutes=0
        GOTO CountDown
	)
	SET /a eMinutes +=1
	SET /a eSeconds=0
    GOTO CountDown
)
SET /a eSeconds +=1

GOTO CountDown


:popup

SET disTimMsg="The %fleet%%doctype% distribution %step% should be done. [%elapsedTime%]"
SET disTitleDisplay="%fleet%%doctype% distribution %step%"
SET PUBTimMsg="%fleet%%doctype% Publishing is complete, prep for toQA Timer. [%elapsedTime%]"
SET PUBTitleDisplay="%fleet%%doctype% %step%"
SET graphicsMSG="%fleet%%doctype% [%step%]Graphics are finished [%elapsedTimer%]"
SET graphicsTitle="%fleet%%doctype% [%step%]Graphics"
SET retryTitle="%fleet%%doctype% retry"
SET retryMSG="retrying %fleet%%doctype% [%elapsedTimer%]"

if '%retry%'=='y' SET timerMSG=%retryMSG% && SET titlebarMSG=%retryTitle% && SET retry=n
IF '%step%'=='PUB' SET timerMSG=%PUBTimMsg% && SET titlebarMSG=%PUBTitleDisplay%
IF '%step%'=='toQA' SET timerMSG=%disTimMsg% && SET titlebarMSG=%disTitleDisplay%
IF '%step%'=='toLive' SET timerMSG=%disTimMsg% && SET titlebarMSG=%disTitleDisplay%
IF '%step%'=='toMX' SET timerMSG=%disTimMsg% && SET titlebarMSG=%disTitleDisplay%
IF '%step%'=='GFX' SET timerMSG=%graphicsMSG% && SET titlebarMSG=%graphicsTitle%
IF '%step%'=='MGFX' SET timerMSG=%graphicsMSG% && SET titlebarMSG=%graphicsTitle%

START /b "" CSCRIPT alert.vbs %timerMSG% %titlebarMSG%
PUSHD %~dp0
SET fin=
TIMEOUT /t 1 /nobreak>nul && CLS && SET /p fin="%fleet% %doctype% %step% complete[y/n]?"

IF '%fin%'=='n' GOTO retry
IF '%step%'=='PUB' SET "step=toQA" && GOTO assigndata
IF '%step%'=='toQA' SET "step=GFXtoQA" && GOTO assigndata
IF '%step%'=='toLive' SET "step=GFXtoLive" && GOTO assigndata
IF '%MX%'=='y' SET "step=toMX" && GOTO assigndata
IF '%step%'=='toMX' SET "step=GFXtoMX" && GOTO assigndata
:end
EXIT
