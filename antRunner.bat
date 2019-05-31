@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0

:begin
::START
SET "pretty=n"

CLS
ECHO.
ECHO      *******  PICK A DOCTYPE  *******
ECHO.
ECHO       175          200          OTHER          
ECHO   ******************************************   
ECHO    a. AMM       r. AMM       1. MIP_CRJ        x. EXIT
ECHO    s. AIPC                   2. skybook
ECHO    d. MIP                    3. skybulletin
ECHO    f. SRMI                   4. forms
ECHO    q. SRM
ECHO    w. SWPM
ECHO.
CHOICE /C asdfqw1234rx /CS /N /M "Pick a target: "
IF "%ERRORLEVEL%"== "1" SET "manual=175_AMM"
IF "%ERRORLEVEL%"== "2" SET "manual=175_AIPC"
IF "%ERRORLEVEL%"== "3" SET "manual=175_MIP"
IF "%ERRORLEVEL%"== "4" SET "manual=175_SRMI"
IF "%ERRORLEVEL%"== "5" SET "manual=175_SRM"
IF "%ERRORLEVEL%"== "6" SET "manual=175_SWPM"
IF "%ERRORLEVEL%"== "7" SET "manual=MIP_CRJ"
IF "%ERRORLEVEL%"== "8" SET "manual=skybook"
IF "%ERRORLEVEL%"== "9" SET "manual=skybulletin"
IF "%ERRORLEVEL%"== "10" SET "manual=forms"
IF "%ERRORLEVEL%"== "11" SET "manual=200_AMM"
IF "%ERRORLEVEL%"== "12" EXIT
IF '%manual%'=='175_AIPC' SET "doctype=swAIPC_ERJ175" && SET "file=swaipc_erj175"
IF '%manual%'=='175_AMM' SET "doctype=swAMM_ERJ175"
IF '%manual%'=='175_MIP' SET "doctype=swMIP_ERJ175" && SET "file=swmip_erj175"
IF '%manual%'=='175_SRMI' SET "doctype=swSRMI_ERJ175" && SET "file=swsrmi_erj175"
IF '%manual%'=='175_SWPM' SET "doctype=swSWPM_ERJ175" && SET "file=swswpm_erj175"
IF '%manual%'=='175_SRM' SET "doctype=swSRM_ERJ175" && SET "file=swsrm_erj175"
IF '%manual%'=='200_AMM' SET "doctype=swAMM_CRJ200" && SET "file=swamm_crj200"
IF '%manual%'=='200_MIP' SET "doctype=swMIP_CRJ" && SET "file=swmip_crj200"
IF '%manual%'=='700_MIP' SET "doctype=swMIP_CRJ" && SET "file=swmip_crj700"
IF '%manual%'=='900_MIP' SET "doctype=swMIP_CRJ" && SET "file=swmip_crj900"
IF '%manual%'=='MIP_CRJ' SET "doctype=swMIP_CRJ" && SET "file=swmip_crj"
IF '%manual%'=='skybook' SET "doctype=skybook" && SET "file=skybook"
IF '%manual%'=='skybulletin' SET "doctype=skybulletin" && SET "file=skybulletin"
IF '%manual%'=='forms' SET "doctype=swForms_MX" && SET "file=swforms_mx"
IF '%manual%'=='sw' SET "doctype=sw"
GOTO build

:build
::SET LOCATION OF BUILD FILES 

SET "loc=C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\docs"
IF '%doctype%'=='skybook' SET "loc=C:\Users\s064075\Desktop\xmlDocs\%doctype%\src"
IF '%doctype%'=='skybulletin' SET "loc=C:\Users\s064075\Desktop\xmlDocs\%doctype%\src"

:manual
::SELECT A MANUAL

CLS
SET /a counter=0
SET choicer=
ECHO.
ECHO     ******* PICK A MANUAL *******
ECHO.
FOR /f "usebackq delims=|" %%f in (`dir /b %loc%`) do (
    SET /a counter+=1
    ECHO !counter!: %%f
    SET choicer[!counter!]=%%f
)
IF !counter!==0 CLS && ECHO. && ECHO nothing setup for this doctype. Try Again. && ECHO. && PAUSE && GOTO begin
IF !counter!==1 SET "num=1" && GOTO onlyone
ECHO.
SET /p num="Pick a target or b to go back: "
IF '%num%'=='b' GOTO begin
:onlyone
SET thisManual=!choicer[%num%]!
SET choicer=docs\!thisManual!
:antrunner
::SELECT A TARGET TO RUN IN ANTRUNNER

CLS
ECHO.
ECHO                      ******* ANTRUNNER *******
ECHO            doctype - %manual%     Manual - %thisManual%
ECHO.
ECHO a. prepare     q. [RUN]basic   z. [RUN]reports   p. copy path      n. new doctype     
ECHO s. convert     w. makeHTML                                         m. new manual
ECHO d. addTOC      e. doShort                                          v. view Files
ECHO f. finalize    r. [RUN]short   t. [DEPLOY]                         x. xPath
ECHO.
CHOICE /C asdfqwertzxvmnp /N /M "Pick a target: "
IF "%ERRORLEVEL%"== "1" SET target=prepare
IF "%ERRORLEVEL%"== "2" SET target=convert
IF "%ERRORLEVEL%"== "3" SET target=addTOC
IF "%ERRORLEVEL%"== "4" SET target=finalize
IF "%ERRORLEVEL%"== "5" SET target=[RUN]basic
IF "%ERRORLEVEL%"== "6" SET target=makeHTML
IF "%ERRORLEVEL%"== "7" SET target=doShort && GOTO runSHORT
IF "%ERRORLEVEL%"== "8" SET target=[RUN]short && GOTO runSHORT
IF "%ERRORLEVEL%"== "9" SET target=[DEPLOY]
IF "%ERRORLEVEL%"== "10" SET target=[RUN]reports
IF "%ERRORLEVEL%"== "11" GOTO xpath
IF "%ERRORLEVEL%"== "12" GOTO viewfile
IF "%ERRORLEVEL%"== "13" GOTO manual
IF "%ERRORLEVEL%"== "14" GOTO begin
IF "%ERRORLEVEL%"== "15" (
    ECHO "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\src" | clip
    GOTO antrunner
)


:runANT
::RUN TARGET

CLS
ECHO "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\src" | clip
CALL ant "-DinputManual=%thisManual%" -buildfile C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\apache.ant %target%
PAUSE

:viewfile
::VIEW FILE IN FOXE
CLS
ECHO.
ECHO                       ******* FILE VIEWER *******
ECHO               doctype - %manual%     Manual - %thisManual%
ECHO.
ECHO a. clean (prepare)         q. original     c. runANT (same target)     n. new doctype
ECHO s. init (convert)          w. html         p. copy path                m. new manual
ECHO d. temp (addTOC)           r. short        y. toggle prettyPrint       u. AntRunner 
ECHO f. reloaded (finalize)                                                 x. xPath
ECHO.

CHOICE /C asdfqwrxcumnyp /N /CS /M "Pick a target%pmsg%: "
IF "%ERRORLEVEL%" == "14" (
        ECHO "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\src" | clip
        GOTO viewfile
)
IF "%ERRORLEVEL%" == "13" (
    IF '!pretty!'=='n' (
        SET "pretty=y" && SET "pmsg= (pretty)" && GOTO viewfile
    )
    IF '!pretty!'=='y' (
        SET "pretty=n" && SET "pmsg=" && GOTO viewfile
    )
)
IF "%ERRORLEVEL%" == "12" GOTO begin
IF "%ERRORLEVEL%" == "11" GOTO manual
IF "%ERRORLEVEL%" == "10" GOTO antrunner
IF "%ERRORLEVEL%" == "9" GOTO runANT
IF "%ERRORLEVEL%" == "8" GOTO xpath
IF "%ERRORLEVEL%" == "7" SET choicer=tmp\!thisManual:~0,-4!-short.xml
IF "%ERRORLEVEL%" == "6" SET choicer=tmp\!thisManual:~0,-4!.html
IF "%ERRORLEVEL%" == "5" SET choicer=docs\!thisManual!
IF "%ERRORLEVEL%" == "4" SET choicer=tmp\!thisManual:~0,-4!-reloaded.xml
IF "%ERRORLEVEL%" == "3" SET choicer=tmp\!thisManual:~0,-4!-temp.xml
IF "%ERRORLEVEL%" == "2" SET choicer=tmp\!thisManual:~0,-4!-init.xml
IF "%ERRORLEVEL%" == "1" SET choicer=tmp\!thisManual:~0,-4!-clean.xml
IF '%pretty%'=='n' START "C:\Program Files\firstobject\foxe.exe" "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\!choicer!"
IF '%pretty%'=='y' (
    tidy -xml --indent auto --indent-attributes yes --indent-spaces 10 --uppercase-tags yes "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\!choicer!" > "C:\Users\s064075\Desktop\temp\!choicer!"
    START "C:\Program Files\firstobject\foxe.exe" "C:\Users\s064075\Desktop\temp\!choicer!"
)
GOTO viewfile

:xpathMenu

CLS
ECHO.
ECHO                    ******* SELECT NEW TARGET FILE *******
ECHO            CURRENT TARGET: %choicer%
ECHO.
ECHO q. !thisManual! (original)
ECHO a. !thisManual:~0,-4!-clean.xml               n. new doctype
ECHO s. !thisManual:~0,-4!-init.xml                m. new manual                
ECHO d. !thisManual:~0,-4!-temp.xml                u. antrunner
ECHO f. !thisManual:~0,-4!-reloaded.xml            v. view files
ECHO w. !thisManual:~0,-4!.html
ECHO r. !thisManual:~0,-4!-short.xml
ECHO.
ECHO Select an file to run an xpath query on.
CHOICE /C asdfqwrxvumn /N /CS /M "Pick a target: "
IF "%ERRORLEVEL%" == "12" GOTO begin
IF "%ERRORLEVEL%" == "11" GOTO manual
IF "%ERRORLEVEL%" == "10" GOTO antrunner
IF "%ERRORLEVEL%" == "9" GOTO viewfile
IF "%ERRORLEVEL%" == "8" SET "thisManual=xPath.xml" && SET target=[RUN]basic && GOTO runANT
IF "%ERRORLEVEL%" == "7" SET choicer=tmp\!thisManual:~0,-4!-short.xml && GOTO runxpath
IF "%ERRORLEVEL%" == "6" SET choicer=tmp\!thisManual:~0,-4!.html && GOTO runxpath
IF "%ERRORLEVEL%" == "5" SET choicer=docs\!thisManual! && GOTO runxpath
IF "%ERRORLEVEL%" == "4" SET choicer=tmp\!thisManual:~0,-4!-reloaded.xml && GOTO runxpath
IF "%ERRORLEVEL%" == "3" SET choicer=tmp\!thisManual:~0,-4!-temp.xml && GOTO runxpath
IF "%ERRORLEVEL%" == "2" SET choicer=tmp\!thisManual:~0,-4!-init.xml && GOTO runxpath
IF "%ERRORLEVEL%" == "1" SET choicer=tmp\!thisManual:~0,-4!-clean.xml && GOTO runxpath

:xpath
SET choicer=docs\!thisManual!
:runxpath
CLS
ECHO.
ECHO                    ******* XPATH RUNNER *******
ECHO               TARGET: %choicer%
ECHO.
ECHO x. select diff target             n. new doctype
ECHO p. [RUN]basic on new file         m. new manual
ECHO o. custom root                    u. antrunner
ECHO                                   v. view files
ECHO.
SET /p expression="enter xpath to generate new file: "
IF '!expression!'=='x' GOTO xpathMenu
IF '!expression!'=='v' GOTO viewfile
IF '!expression!'=='u' GOTO antrunner
IF '!expression!'=='m' GOTO manual
IF '!expression!'=='n' GOTO begin
IF '!expression!'=='p' SET "thisManual=xPath.xml" && SET target=[RUN]basic && GOTO runANT
SET "root=C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%"
SET "dtd=%root%\%doctype%.dtd"
SET thisFile="%root%\transform\!choicer!"
IF '!expression!'=='o' GOTO xpathWithRoot
::working
tidy -q -xml !thisFile! | findstr /R "?xml DOCTYPE ENTITY dtd \]> ^\[$" > %root%\transform\docs\xPath.xml
REM tidy -q -xml --doctype omit --numeric-entities yes !thisFile! | xml sel -t -c "%expression%"  >>  %root%\transform\docs\xPath.xml
xml -q fo -D !thisFile! | tidy -q -xml | xml sel -t -c "%expression%"  >>  %root%\transform\docs\xPath.xml
START %root%\transform\docs\xPath.xml
GOTO xpath

:xpathWithRoot
SET /p xpathroot="enter the name of new root element: "
SET /p expression="enter xpath to transform body of new root: "
IF '!expression!'=='x' GOTO xpathMenu
IF '!expression!'=='v' GOTO viewfile
IF '!expression!'=='u' GOTO antrunner
IF '!expression!'=='m' GOTO manual
IF '!expression!'=='n' GOTO begin
IF '!expression!'=='p' SET "thisManual=xPath.xml" && SET target=[RUN]basic && GOTO runANT

xml -q fo --dropdtd !thisFile! | xml sel -t -e "%xpathroot%" -c "%expression%" > %root%\transform\docs\xPath.xml
START %root%\transform\docs\xPath.xml
GOTO xpath

:runSHORT
SET /p shortChapters="enter chapters for short "
ECHO "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\src" | clip
ECHO "%doctype%"
ECHO !manual!
IF NOT "!manual!"=="MIP_CRJ" ( 
    CALL ant "-DinputManual=%thisManual%" "-Dpname=chapters" "-Dchapters=%shortChapters%" -buildfile C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\apache.ant %target%
)
IF "!manual!"=="MIP_CRJ" (
    SET /p shortInspections="enter inspections for short "
    CALL ant "-DinputManual=!thisManual!" "-Dpname=chapters" "-Dchapters=!shortChapters!" "-Diname=inspections" "-Dinspections=!shortInspections!" -buildfile C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\apache.ant %target%
)
PAUSE
GOTO viewfile

:end