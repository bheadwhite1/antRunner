@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0
:begin

CLS
ECHO a. AntRunner/xPath     b. Build for Dev
ECHO s. Copy script         w. Watch css
ECHO d. Tech Publisher
ECHO f. Open ContentURL

CHOICE /C asdfbw /CS /N /M "Pick a task: "


IF "%ERRORLEVEL%"== "1" START antRunner.bat && GOTO begin
IF "%ERRORLEVEL%"== "2" START Copy.bat && GOTO begin
IF "%ERRORLEVEL%"== "3" START Timer.bat && GOTO begin
IF "%ERRORLEVEL%"== "4" CALL ContentUrl.bat && GOTO begin
IF "%ERRORLEVEL%"== "5" GOTO build
IF "%ERRORLEVEL%"== "6" start csswatch.bat
GOTO begin


REM :ant
REM CLS
REM ::WHICH MANUAL?
REM ECHO.
REM ECHO       175          200          OTHER
REM ECHO   ******************************************
REM ECHO    a. AMM       w. AMM       1. MIP_CRJ
REM ECHO    s. AIPC                   2. skybook
REM ECHO    d. MIP                    3. skybulletin
REM ECHO    f. SRMI                   4. forms
REM ECHO    q. SRM
REM ECHO.
REM ECHO.

REM CHOICE /C asdfqw1234 /CS /N /M "Which manual? "
REM IF "%ERRORLEVEL%"== "1" SET "manual=175_AMM"
REM IF "%ERRORLEVEL%"== "2" SET "manual=175_AIPC"
REM IF "%ERRORLEVEL%"== "3" SET "manual=175_MIP"
REM IF "%ERRORLEVEL%"== "4" SET "manual=175_SRMI"
REM IF "%ERRORLEVEL%"== "5" SET "manual=175_SRM"
REM IF "%ERRORLEVEL%"== "6" SET "manual=200_AMM"
REM IF "%ERRORLEVEL%"== "7" SET "manual=MIP_CRJ"
REM IF "%ERRORLEVEL%"== "8" SET "manual=skybook"
REM IF "%ERRORLEVEL%"== "9" SET "manual=skybulletin"
REM IF "%ERRORLEVEL%"== "10" SET "manual=forms"

REM REM SET /a counter=0
REM REM SET choice=
REM REM FOR /F "tokens=*" %%A in (assets.txt) DO (
REM REM     SET /a counter+=1
REM REM     ECHO !counter!: %%A
REM REM     SET choice[!counter!]=%%A
REM REM )

REM REM SET /p num="Enter # of a doctype to copy: "
REM REM SET manual=!choice[%num%]!

REM GOTO assignData

REM :build
REM ::SET LOCATION OF BUILD FILES 
REM SET "loc=C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\docs"
REM IF '%doctype%'=='skybook' SET "loc=C:\Users\s064075\Desktop\xmlDocs\%doctype%\src"
REM IF '%doctype%'=='skybulletin' SET "loc=C:\Users\s064075\Desktop\xmlDocs\%doctype%\src"

REM CLS
REM SET /a counter=0
REM SET choice=
REM FOR /f "usebackq delims=|" %%f in (`dir /b %loc%`) do (
REM     SET /a counter+=1
REM     ECHO !counter!: %%f
REM     SET choice[!counter!]=%%f
REM )
REM SET /p num="Enter a manual to run in eclipse: "
REM SET thisManual=!choice[%num%]!

REM :newtarget
REM CLS
REM ECHO a. prepare     q. [RUN]basic   z. [RUN]reports
REM ECHO s. convert     w. makeHTML     x. GOTO temp Dir
REM ECHO d. addTOC      e. [DEPLOY]
REM ECHO f. finalize    r. [RUN]short

REM CHOICE /C asdfqwerzx /N /M "Pick a target: "

REM IF "%ERRORLEVEL%"== "1" SET target=prepare
REM IF "%ERRORLEVEL%"== "2" SET target=convert
REM IF "%ERRORLEVEL%"== "3" SET target=addTOC
REM IF "%ERRORLEVEL%"== "4" SET target=finalize
REM IF "%ERRORLEVEL%"== "5" SET target=[RUN]basic
REM IF "%ERRORLEVEL%"== "6" SET target=makeHTML
REM IF "%ERRORLEVEL%"== "7" SET target=[DEPLOY]
REM IF "%ERRORLEVEL%"== "8" SET target=[run]short
REM IF "%ERRORLEVEL%"== "9" SET target=[run]reports
REM IF "%ERRORLEVEL%"== "10" GOTO viewfile


REM :runeclipse

REM CLS
REM CALL ant "-DinputManual=%thisManual%" -buildfile C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\apache.ant %target%
REM PAUSE

REM :viewfile

REM CLS
REM ECHO.
REM ECHO PICK AN XML TO VIEW IN FOXE.
REM ECHO a. original        q. clean (prepare)      c. rerun same target
REM ECHO f. html            w. init (convert)       v. rerun with new target
REM ECHO                    e. temp (addTOC)        b. Main Menu
REM ECHO                    r. reloaded (finalize)

REM CHOICE /C cbaqwerfv /N /CS /M "select an option.. "

REM IF "%ERRORLEVEL%" == "9" GOTO newtarget
REM IF "%ERRORLEVEL%" == "8" SET choice=tmp\!thisManual:~0,-4!.html
REM IF "%ERRORLEVEL%" == "7" SET choice=tmp\!thisManual:~0,-4!-reloaded.xml
REM IF "%ERRORLEVEL%" == "6" SET choice=tmp\!thisManual:~0,-4!-temp.xml
REM IF "%ERRORLEVEL%" == "5" SET choice=tmp\!thisManual:~0,-4!-init.xml
REM IF "%ERRORLEVEL%" == "4" SET choice=tmp\!thisManual:~0,-4!-clean.xml
REM IF "%ERRORLEVEL%" == "3" SET choice=src\!thisManual!
REM IF "%ERRORLEVEL%" == "2" GOTO begin
REM IF "%ERRORLEVEL%" == "1" GOTO runeclipse

REM START "C:\Program Files\firstobject\foxe.exe" "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\transform\!choice!

REM GOTO viewfile

:build
ECHO. 
ECHO Step 1: Pull master techuser. . .
ECHO Step 2: Merge master to local. . .
ECHO.
PAUSE

CLS
START ant -buildfile C:\techuser\SkyWestBuild.ant [development]build_and_deploy_FOR_DEV
GOTO begin

REM :assignData
REM IF '%manual%'=='175_AIPC' SET "doctype=swAIPC_ERJ175" && SET "file=swaipc_erj175"
REM REM IF '%manual%'=='175_AMM' SET "doctype=swAMM_ERJ175" && SET "file=NA"
REM IF '%manual%'=='175_MIP' SET "doctype=swMIP_ERJ175" && SET "file=swmip_erj175"
REM IF '%manual%'=='175_SRMI' SET "doctype=swSRMI_ERJ175" && SET "file=swsrmi_erj175"
REM IF '%manual%'=='175_SRM' SET "doctype=swSRM_ERJ175" && SET "file=swsrm_erj175"
REM REM IF '%manual%'=='200_AMM' SET "doctype=swAMM_CRJ200" && SET "file=NA"
REM IF '%manual%'=='200_MIP' SET "doctype=swMIP_CRJ" && SET "file=swmip_crj200"
REM IF '%manual%'=='700_MIP' SET "doctype=swMIP_CRJ" && SET "file=swmip_crj700"
REM IF '%manual%'=='900_MIP' SET "doctype=swMIP_CRJ" && SET "file=swmip_crj900"
REM IF '%manual%'=='MIP_CRJ' SET "doctype=swMIP_CRJ" && SET "file=swmip_crj"
REM IF '%manual%'=='skybook' SET "doctype=skybook" && SET "file=skybook"
REM IF '%manual%'=='skybulletin' SET "doctype=skybulletin" && SET "file=skybulletin"
REM IF '%manual%'=='forms' SET "doctype=swForms_MX" && SET "file=swforms_mx"
REM IF '%manual%'=='sw' SET "doctype=sw"
REM GOTO build

REM :end