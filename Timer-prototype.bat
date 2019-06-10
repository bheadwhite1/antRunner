@ECHO off
SETLOCAL enabledelayedexpansion

:pickTimer
MODE con: cols=48 lines=10

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

CLS
ECHO.
ECHO 1. 175 MIP Timer
ECHO 2. 200 MIP Timer
ECHO 3. 700 MIP Timer
ECHO 4. 900 MIP Timer
ECHO 5. Distribution Timer
SET choice=
SET /p choice=Select Timer.
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF '%choice%'=='1' (
    SET "fleet=175"
    SET doctype=MIP
    SET step=PUB
    SET Hours=1
    SET Minutes=10
    REM SET /a Seconds=2
    SET timerDisplay=!fleet! !doctype! !step!
    SET titlebarMSG="175 MIP Timer"
    SET timerMSG="175 MIP Publishing should be complete, ready to begin toQA Timer"
    SET /p correctFile="fromEditor file up to date? copy?"

    IF !correctFile!==n GOTO eclipse
    CALL fromEditCopy.bat "Maintenance Inspection Program (mip).xml" "C:\techuser\doctypes\swMIP_ERJ175\transform\docs"
    :eclipse
    SET /p runEclipse="run eclipse?"
    IF !runEclipse!==n (
        MODE con:cols=34 lines=3
        GOTO CountDown 
    )
    CALL eclipse.bat "Maintenance Inspection Program (mip).xml" "175MIP" "swMIP_ERJ175"
    MODE con:cols=34 lines=3
    GOTO CountDown
    )
IF '%choice%'=='2' (
    SET "fleet=200"
    SET doctype=MIP
    SET step=PUB
    SET Hours=1
    SET Minutes=20
    REM SET /a Seconds=2
    SET timerDisplay=!fleet! !doctype! !step!
    SET titlebarMSG="200 MIP Timer"
    SET timerMSG="200 MIP Publishing should be complete, ready to begin toQA Timer"
    SET /p correctFile="fromEditor file up to date? copy?"

    IF !correctFile!==n GOTO eclipse
    CALL fromEditCopy.bat "MIP CRJ 200.xml" "C:\techuser\doctypes\swMIP_CRJ\transform\docs"
    :eclipse
    SET /p runEclipse="run eclipse?"
    IF !runEclipse!==n (
        MODE con:cols=34 lines=3
        GOTO CountDown 
    )
    CALL eclipse.bat "MIP CRJ 200.xml" "200MIP" "swMIP_CRJ"
    MODE con:cols=34 lines=3
    GOTO CountDown
    )
IF '%choice%'=='3' (
    SET "fleet=700"
    SET doctype=MIP
    SET step=PUB
    SET Hours=1
    REM SET /a Seconds=2
    SET timerDisplay=!fleet! !doctype! !step!
    SET titlebarMSG="700 MIP Timer"
    SET timerMSG="700 MIP Publishing should be complete, ready to begin toQA Timer"
    SET /p correctFile="fromEditor file up to date? copy?"

    IF !correctFile!==n GOTO eclipse
    CALL fromEditCopy.bat "CRJ 700 MIP - Rev 25.xml" "C:\techuser\doctypes\swMIP_CRJ\transform\docs"
    :eclipse
    SET /p runEclipse="run eclipse?"
    IF !runEclipse!==n (
        MODE con:cols=34 lines=3
        GOTO CountDown 
    )
    CALL eclipse.bat "CRJ 700 MIP - Rev 25.xml" "700MIP" "swMIP_CRJ"
    MODE con:cols=34 lines=3
    GOTO CountDown
    )
IF '%choice%'=='4' (
    SET "fleet=900"
    SET doctype=MIP
    SET step=PUB
    SET Hours=1
    REM SET /a Seconds=2
    SET timerDisplay=!fleet! !doctype! !step!
    SET titlebarMSG="900 MIP Timer"
    SET timerMSG="900 MIP Publishing should be complete, ready to begin toQA Timer"
    SET /p correctFile="fromEditor file up to date? copy?"

    IF !correctFile!==n GOTO eclipse
    CALL fromEditCopy.bat "CRJ 900 MIP - Rev 27.xml" "C:\techuser\doctypes\swMIP_CRJ\transform\docs"
    :eclipse
    SET /p runEclipse="run eclipse?"
    IF !runEclipse!==n (
        MODE con:cols=34 lines=3
        GOTO CountDown 
    )
    CALL eclipse.bat "CRJ 900 MIP - Rev 27.xml" "900MIP" "swMIP_CRJ"
    MODE con:cols=34 lines=3
    GOTO CountDown
    )
IF '%choice%'=='5' (
    SET script=alert.vbs
    GOTO DISTRIBUTE
    )
ECHO "%choice%" is NOT valid, try again
ECHO.
GOTO pickTimer

:DISTRIBUTE
REM ECHO DISTRIBUTE
REM PAUSE
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
ECHO 3. Other
ECHO.

CHOICE /C 123 /M "Pick a doctype:"

IF ERRORLEVEL 1 SET doctype=AMM
IF ERRORLEVEL 2 SET doctype=MIP
IF ERRORLEVEL 3 SET doctype=Other

CLS
ECHO 1. toQA
ECHO 2. toLIVE
ECHO 3. to...
ECHO.

CHOICE /C 123 /M "Pick a distributing step:"

IF ERRORLEVEL 1 SET step=toQA
IF ERRORLEVEL 2 (
    START /b "" CSCRIPT alert.vbs "Are paperclips done?" "Paperclips"
    PUSHD %~dp0
    SET fin=
    timeout /t 1 /nobreak>nul && PAUSE
    SET step=toLive
)
IF ERRORLEVEL 3 SET step=..

:distributeNow
REM ECHO distributeNow
REM ECHO %doctype% %step% %fleet%
REM PAUSE
SET manual=Distribution of %fleet%%doctype%%step%
::AMM
IF "%doctype%"=="AMM" (
    IF "%step%"=="toQA" (
        IF "%fleet%"=="900" (
            ECHO nodata
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO end
        )
        IF "%fleet%"=="700" (
            ECHO nodata
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO end
        )
        IF "%fleet%"=="200" (
            ECHO nodata
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO end
        )
        IF "%fleet%"=="175" (
            SET Minutes=10
            REM SET /a Seconds=2
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO CountDown
        )  
    )
    IF "%step%"=="toLive" (
        IF "%fleet%"=="900" (
            ECHO nodata
            GOTO end
        )
        IF "%fleet%"=="700" (
            ECHO nodata
            GOTO end
        )
        IF "%fleet%"=="200" (
            ECHO nodata
            GOTO end
        )
        IF "%fleet%"=="175" (
            SET Hours=1
            REM SET /a Seconds=2
            GOTO CountDown
        )  
    )
    IF "%step%"==".." (
        IF "%fleet%"=="900" (
            ECHO nodata
            GOTO end
        )
        IF "%fleet%"=="700" (
            ECHO nodata
            GOTO end
        )
        IF "%fleet%"=="200" (
            ECHO nodata
            GOTO end
        )
        IF "%fleet%"=="175" (
            ECHO nodata
            GOTO end
        )  
    )
)
::MIP
IF "%doctype%"=="MIP" (
    IF "%step%"=="toQA" (
        IF "%fleet%"=="900" (
           SET Minutes=5
        REM    SET /a Seconds=2
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO CountDown
        )
        IF "%fleet%"=="700" (
            SET Minutes=5
            REM SET /a Seconds=2
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO CountDown
        )
        IF "%fleet%"=="200" (
            SET Minutes=5
            REM SET /a Seconds=2
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO CountDown
        )
        IF "%fleet%"=="175" (
            SET Minutes=5
            REM SET /a Seconds=2
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO CountDown
        )  
    )
    IF "%step%"=="toLive" (
        IF "%fleet%"=="900" (
            SET Minutes=30
            REM SET /a Seconds=2
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO CountDown
        )
        IF "%fleet%"=="700" (
            SET Minutes=30
            REM SET /a Seconds=2
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO CountDown
        )
        IF "%fleet%"=="200" (
            SET Minutes=20
            REM SET /a Seconds=2
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO CountDown
        )
        IF "%fleet%"=="175" (
            SET Minutes=27
            REM SET /a Seconds=2
            SET timerDisplay=!fleet! !doctype! !step!
            MODE con:cols=34 lines=3
            GOTO CountDown
        )  
    )
    IF "%step%"==".." (
        IF "%fleet%"=="900" (
            ECHO nodata
            GOTO end
        )
        IF "%fleet%"=="700" (
            ECHO nodata
            GOTO end
        )
        IF "%fleet%"=="200" (
            ECHO nodata
            GOTO end
        )
        IF "%fleet%"=="175" (
            ECHO nodata
            GOTO end
        )  
    )
)
::OTHER
IF "%doctype%"=="Other" (
    IF "%step%"=="toQA" (
       IF "%fleet%"=="900" (
            
        )
        IF "%fleet%"=="700" (

        )
        IF "%fleet%"=="200" (

        )
        IF "%fleet%"=="175" (

        )   
    )
    IF "%step%"=="toLive" (
        IF "%fleet%"=="900" (
            
        )
        IF "%fleet%"=="700" (

        )
        IF "%fleet%"=="200" (

        )
        IF "%fleet%"=="175" (

        )  
    )
    IF "%step%"==".." (
        IF "%fleet%"=="900" (
            
        )
        IF "%fleet%"=="700" (

        )
        IF "%fleet%"=="200" (

        )
        IF "%fleet%"=="175" (

        )  
    )
)
SET /a Seconds=1
MODE con:cols=60 lines=4

GOTO Countdown

:CountDown
CLS
ECHO [%Hours%:%Minutes%:%Seconds%][%eHours%:%eMinutes%:%eSeconds%] %timerDisplay%

TIMEOUT /t 1 /nobreak>Nul
IF "%Seconds%"=="0" (
	IF "%Minutes%"=="0" (
		IF "%Hours%"=="0" (
			IF "%Days%"=="0" (

				GOTO setvbsmessage
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

:setvbsmessage
REM ECHO setvbsmessage 
REM PAUSE
IF NOT '%step%'=='Publishing' (
    IF '%step%'=='toQA' (
        IF '%graphics%'=='false' (
        SET timerMSG="The %fleet% %doctype% distribution should be done."
        SET titlebarMSG="%fleet% %manual% distribution"
        SET rangraphics=false
        SET graphics=true
        SET toDistribute=false
        GOTO popalert
        )
    )
    IF '%step%'=='toLive' (
        IF '%graphics%'=='false' (
        SET timerMSG="The %fleet% %doctype% distribution should be done."
        SET titlebarMSG="%fleet% %manual% distribution"
        SET toDistribute=false
        SET rangraphics=false
        SET graphics=true
        SET mxonly=true
        GOTO popalert
        )
    )
)
GOTO popalert

:popalert
REM ECHO popalert
REM PAUSE

START /b "" CSCRIPT alert.vbs %timerMSG% %titlebarMSG%
PUSHD %~dp0
SET fin=
TIMEOUT /t 1 /nobreak>nul && SET /p fin="%fleet% %doctype% %step% complete[y/n]?"

IF '%fin%'=='n' GOTO retry
IF '%toDistribute%'=='true' GOTO distributePrep
IF '%graphics%'=='true' GOTO popgraphics
IF '%mxonly%'=='true' GOTO mx
IF '%mxgraphics%'=='true' GOTO mxgraphics

GOTO end

:distributePrep
REM ECHO distributePrep
REM PAUSE

SET step=toQA
GOTO distributeNow

:retry
REM ECHO tryagain
REM PAUSE

SET /a Minutes=10
REM SET /a Seconds=2

SET "timerDisplay=xtra %fleet% %doctype% %step%"
MODE con:cols=40 lines=3
GOTO CountDown

:popgraphics
REM ECHO popgraphics
REM PAUSE
SET step=GRAPHICS
SET timerDisplay=%fleet% !doctype! !step!
SET graphics=false
SET timerMSG="are the !timerDisplay! complete?"
SET Minutes=5
REM SET /a Seconds=2
GOTO CountDown

:mx
REM ECHO mx
REM PAUSE

SET step=MXONLY
SET timerDisplay=%fleet% !doctype! !step!
SET mxonly=false
SET mxgraphics=true

SET timerMSG="is data sent to !timerDisplay!?"

SET Minutes=5
REM SET /a Seconds=2
GOTO Countdown

:mxgraphics
REM ECHO mxgraphics
REM PAUSE
SET step=MXGRAPHICS
SET timerDisplay=%fleet% !doctype! !step!
SET mxgraphics=false
SET timerMSG="are the !timerDisplay! complete?"

SET Minutes=5
REM SET /a Seconds=2
GOTO CountDown
:end