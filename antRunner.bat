@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0

:begin
::START

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
IF "%ERRORLEVEL%"== "12" SET "manual=200_AMM"
IF "%ERRORLEVEL%"== "11" EXIT
IF '%manual%'=='175_AIPC' SET "doctype=swAIPC_ERJ175" && SET "file=swaipc_erj175"
IF '%manual%'=='175_AMM' SET "doctype=swAMM_ERJ175"
IF '%manual%'=='175_MIP' SET "doctype=swMIP_ERJ175" && SET "file=swmip_erj175"
IF '%manual%'=='175_SRMI' SET "doctype=swSRMI_ERJ175" && SET "file=swsrmi_erj175"
IF '%manual%'=='175_SWPM' SET "doctype=swSWPM_ERJ175" && SET "file=swswpm_erj175"
IF '%manual%'=='175_SRM' SET "doctype=swSRM_ERJ175" && SET "file=swsrm_erj175"
REM IF '%manual%'=='200_AMM' SET "doctype=swAMM_CRJ200" && SET "file=NA"
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
ECHO     *******  PICK A MANUAL for the %doctype% doctype  *******
ECHO.
FOR /f "usebackq delims=|" %%f in (`dir /b %loc%`) do (
    SET /a counter+=1
    ECHO !counter!: %%f
    SET choicer[!counter!]=%%f
)
IF !counter!==0 CLS && ECHO. && ECHO nothing setup for this doctype. Try Again. && ECHO. && PAUSE && GOTO begin
ECHO.
SET /p num="Pick a target or b to go back: "
IF '%num%'=='b' GOTO begin
SET thisManual=!choicer[%num%]!
SET choicer=docs\!thisManual!
:antrunner
::SELECT A TARGET TO RUN IN ANTRUNNER

CLS
ECHO.
ECHO                    *******  Execute ANTRUNNER on %thisManual%  *******
ECHO.
ECHO a. prepare     q. [RUN]basic   z. [RUN]reports     b. go back                          p. copy path
ECHO s. convert     w. makeHTML                         x. run xPath on %thisManual%
ECHO d. addTOC      e. doShort                          v. view %thisManual% Temp Files
ECHO f. finalize    r. [RUN]short   t. [DEPLOY]         n. new doctype
ECHO.
CHOICE /C asdfqwertzxvbnp /N /M "Pick a target: "
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
ECHO                       *******  %manual% FILE VIEWER  *******
ECHO.
ECHO a. clean (prepare)         q. original     c. rerun w/ same target     p. copy path
ECHO s. init (convert)          w. html         v. AntRunner
ECHO d. temp (addTOC)           r. short        b. new manual
ECHO f. reloaded (finalize)     x. xPath        n. new doctype
ECHO.
CHOICE /C asdfqwrxcvbnp /N /CS /M "Pick a target: "
IF "%ERRORLEVEL%" == "12" (
        ECHO "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\src" | clip
        GOTO viewfile
)
IF "%ERRORLEVEL%" == "12" GOTO begin
IF "%ERRORLEVEL%" == "11" GOTO manual
IF "%ERRORLEVEL%" == "10" GOTO antrunner
IF "%ERRORLEVEL%" == "9" GOTO runANT
IF "%ERRORLEVEL%" == "8" GOTO runXpa
IF "%ERRORLEVEL%" == "7" SET choicer=tmp\!thisManual:~0,-4!-short.xml
IF "%ERRORLEVEL%" == "6" SET choicer=tmp\!thisManual:~0,-4!.html
IF "%ERRORLEVEL%" == "5" SET choicer=docs\!thisManual!
IF "%ERRORLEVEL%" == "4" SET choicer=tmp\!thisManual:~0,-4!-reloaded.xml
IF "%ERRORLEVEL%" == "3" SET choicer=tmp\!thisManual:~0,-4!-temp.xml
IF "%ERRORLEVEL%" == "2" SET choicer=tmp\!thisManual:~0,-4!-init.xml
IF "%ERRORLEVEL%" == "1" SET choicer=tmp\!thisManual:~0,-4!-clean.xml
START "C:\Program Files\firstobject\foxe.exe" "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\!choicer!
GOTO viewfile

:runXpa
::PERFORM XPATH ON SELECTED FILE & GENERATE NEW XPATH FILE

CLS
ECHO.
ECHO         *******  %manual%  XPATH RUNNER  *******
ECHO.
ECHO s. init (convert)         w. html              v. AntRunner Menu
ECHO a. clean (prepare)        q. original          c. AntRunner on new xPath File 
ECHO d. temp (addTOC)                               b. new manual
ECHO f. reloaded (finalize)    r. short             n. new doctype
ECHO.
ECHO Select an file to run an xpath query on.
CHOICE /C asdfqwrcvbn /N /CS /M "Pick a target: "
IF "%ERRORLEVEL%" == "11" GOTO begin
IF "%ERRORLEVEL%" == "10" GOTO manual
IF "%ERRORLEVEL%" == "9" GOTO antrunner
IF "%ERRORLEVEL%" == "8" SET "target=[RUN]basic" && SET "thisManual=xPath.xml" && GOTO runANT
IF "%ERRORLEVEL%" == "7" SET choicer=tmp\!thisManual:~0,-4!-short.xml
IF "%ERRORLEVEL%" == "6" SET choicer=tmp\!thisManual:~0,-4!.html
IF "%ERRORLEVEL%" == "5" SET choicer=docs\!thisManual!
IF "%ERRORLEVEL%" == "4" SET choicer=tmp\!thisManual:~0,-4!-reloaded.xml
IF "%ERRORLEVEL%" == "3" SET choicer=tmp\!thisManual:~0,-4!-temp.xml
IF "%ERRORLEVEL%" == "2" SET choicer=tmp\!thisManual:~0,-4!-init.xml
IF "%ERRORLEVEL%" == "1" SET choicer=tmp\!thisManual:~0,-4!-clean.xml

CLS
:xpath
SET /p expression="type in the xpath expression to view in %choicer%  "
SET "root=C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%"
SET "dtd=%root%\%doctype%.dtd"
SET "thisFile=%root%\transform\!choicer!"

:: working with xmllint
REM findstr /V /R "DOCTYPE ENTITY ]" !thisFile! | xmllint --recover --xmlout --xpath %expression% - >%root%\transform\docs\xPath.xml
:: working with xmlstarlet
tidy -xml -numeric -q !thisFile! | findstr /V /R "ENTITY NOTATION" | xml sel -t -c %expression% > %root%\transform\docs\xPath.xml
START %root%\transform\docs\xPath.xml
GOTO runXpa

:runSHORT
SET /p shortChapters="enter chapters for short "
ECHO "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\src" | clip
CALL ant "-DinputManual=%thisManual%" "-Dpname=chapters" "-Dchapters=%shortChapters%" -buildfile C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\apache.ant %target%
PAUSE
GOTO viewfile

:end