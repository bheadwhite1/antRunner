@ECHO OFF
SETLOCAL enabledelayedexpansion
::operate out of the same directory of this batch
PUSHD %~dp0

:begin
CLS
ECHO COPY FROM....
ECHO.
ECHO a. Local 44 doctypes
ECHO s. fromEditor
ECHO.
CHOICE /C as /CS /N /M "Copy from where? "
IF "%ERRORLEVEL%"=="1" GOTO local
IF "%ERRORLEVEL%"=="2" GOTO fromEditor

:local
CLS
ECHO.
ECHO      175          200          OTHER
ECHO ******************************************
ECHO   a. AMM       r. AMM       1. MIP_CRJ
ECHO   s. AIPC                   2. skybook
ECHO   d. MIP                    3. skybulletin
ECHO   f. NDT                    4. forms
ECHO   q. SRMI
ECHO   w. SRM
ECHO   e. SWPM
ECHO.
ECHO.

CHOICE /C asdfqwer1234 /CS /N /M "Which manual? "
IF "%ERRORLEVEL%"== "1" SET "manual=175_AMM"
IF "%ERRORLEVEL%"== "2" SET "manual=175_AIPC"
IF "%ERRORLEVEL%"== "3" SET "manual=175_MIP"
IF "%ERRORLEVEL%"== "4" SET "manual=175_NDT"
IF "%ERRORLEVEL%"== "5" SET "manual=175_SRMI"
IF "%ERRORLEVEL%"== "6" SET "manual=175_SRM"
IF "%ERRORLEVEL%"== "7" SET "manual=175_SWPM"
IF "%ERRORLEVEL%"== "8" SET "manual=200_AMM"
IF "%ERRORLEVEL%"== "9" SET "manual=MIP_CRJ"
IF "%ERRORLEVEL%"== "10" SET "manual=skybook"
IF "%ERRORLEVEL%"== "11" SET "manual=skybulletin"
IF "%ERRORLEVEL%"== "12" SET "manual=forms"

GOTO assignData

::WHERE?
:copyWhere
CLS
ECHO Copying %file% to...
ECHO 1. LOCAL
ECHO 2. DEVSTAGE
ECHO 3. DEVQA
ECHO 4. STAGE
ECHO 5. QA

CHOICE /C 12345b /CS /N /M "Copy where? (hit 'b' to go back)"
IF "%ERRORLEVEL%" == "6" GOTO begin
IF "%ERRORLEVEL%" == "5" SET "root=\\sgutviewqa01\e$\"
IF "%ERRORLEVEL%" == "4" SET "root=\\sgutviewstage01\e$\"
IF "%ERRORLEVEL%" == "3" SET "root=\\sgutviewdevqa01\e$\"
IF "%ERRORLEVEL%" == "2" SET "root=\\sgutviewdevstage01\e$\"
IF "%ERRORLEVEL%" == "1" SET "root=C:\"

::css/js copy
ROBOCOPY "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%" "%root%techuser\doctypes\%doctype%" "%file%.css" "%file%.js" /LEV:1
::processes copy
ROBOCOPY "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\processes" "%root%techuser\doctypes\%doctype%\processes" "aa_prepareXML.xsl" "ab_doTechview.xsl" "ac_generateTOC.xsl" "ad_finalizeXML.xsl" /LEV:1
::transform copy
ROBOCOPY "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%doctype%\common\xslt" "%root%techuser\doctypes\%doctype%\common\xslt"
PAUSE
GOTO end

:assignData
IF '%manual%'=='175_AIPC' SET "doctype=swAIPC_ERJ175" && SET "file=swaipc_erj175"
REM IF '%manual%'=='175_AMM' SET "doctype=swAMM_ERJ175" && SET "file=NA"
IF '%manual%'=='175_MIP' SET "doctype=swMIP_ERJ175" && SET "file=swmip_erj175"
IF '%manual%'=='175_NDT' SET "doctype=swNDT_ERJ175" && SET "file=swndt_erj175"
IF '%manual%'=='175_SRMI' SET "doctype=swSRMI_ERJ175" && SET "file=swsrmi_erj175"
IF '%manual%'=='175_SRM' SET "doctype=swSRM_ERJ175" && SET "file=swsrm_erj175"
IF '%manual%'=='175_SWPM' SET "doctype=swSWPM_ERJ175" && SET "file=swswpm_erj175"
REM IF '%manual%'=='200_AMM' SET "doctype=swAMM_CRJ200" && SET "file=NA"
IF '%manual%'=='200_MIP' SET "doctype=swMIP_CRJ200" && SET "file=swmip_crj200"
IF '%manual%'=='700_MIP' SET "doctype=swMIP_CRJ700" && SET "file=swmip_crj700"
IF '%manual%'=='900_MIP' SET "doctype=swMIP_CRJ900" && SET "file=swmip_crj900" 
IF '%manual%'=='MIP_CRJ' SET "doctype=swMIP_CRJ" && SET "file=swmip_crj"
IF '%manual%'=='skybook' SET "doctype=skybook" && SET "file=skybook"
IF '%manual%'=='skybulletin' SET "doctype=skybulletin" && SET "file=skybulletin"
IF '%manual%'=='forms' SET "doctype=swForms_MX" && SET "file=swforms_mx"
IF '%manual%'=='sw' SET "doctype=sw"
GOTO copyWhere

:fromEditor
ECHO.
ECHO      175          200          700          900
ECHO ****************************************************
ECHO   a. AMM       d. AMM       1. MIP       2. MIP      
ECHO   s. MIP       f. MIP
ECHO.
ECHO.
CHOICE /C asdf12 /CS /N /M "Which manual? "
IF "%ERRORLEVEL%"== "1" SET "search=MPP" && SET "fleet=175" && SET "manual=AMM"
IF "%ERRORLEVEL%"== "2" SET "search=mip" && SET "fleet=175" && SET "manual=MIP"
IF "%ERRORLEVEL%"== "3" SET "search=MPP" && SET "fleet=200" && SET "manual=AMM"
IF "%ERRORLEVEL%"== "4" SET "search=200" && SET "fleet=200" && SET "manual=MIP"
IF "%ERRORLEVEL%"== "5" SET "search=700" && SET "fleet=700" && SET "manual=MIP"
IF "%ERRORLEVEL%"== "6" SET "search=900" && SET "fleet=900" && SET "manual=MIP"

SET /a counter=0
SET /a number=0
SET choice=
SET bool=f
FOR /f "usebackq delims=|" %%f in (`dir /b /O:-D "\\sgudocstage\Documents\JaredLisa\skytrackprocess\src\fromEditor"`) do (
    IF !counter! LSS 20 (
        ECHO %%f|find "!search!" >NUL
        SET /a counter+=1
        IF NOT ERRORLEVEL 1 (
            SET /a number+=1
            SET choice[!number!]=%%f
            ECHO !number!: %%f
        )
    )
)

SET /p num="Enter the number of the manual you'd like to copy: "
SET thisManual=!choice[%num%]!

:robocopy
MODE con:cols=70 lines=10
SET titlebarMSG="%fleet% %doctype% Timer"
SET timerMSG="%fleet% %doctype% Publishing should be complete, ready to begin toQA Timer"
CLS
ECHO 1. Copy %thisManual%
ECHO 2. Skip
ECHO.
CHOICE /c 12 /t 10 /d 1 /cs /n /m "copy %thisManual%?"
IF "!fleet!"=="175" (
    IF '!manual!'=='MIP' (
        CALL fromEditCopy.bat "!thisManual!" "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\swMIP_ERJ175\transform\docs"
    )
    IF '!doctype!'==AMM (
        CALL fromEditCopy.bat "!thisManual!" "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\swAMM_ERJ175\processes\docs"
    )
)
IF "%fleet%"=="200" CALL fromEditCopy.bat "!thisManual!" "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\swMIP_CRJ\transform\docs"
IF "%fleet%"=="700" CALL fromEditCopy.bat "!thisManual!" "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\swMIP_CRJ\transform\docs"
IF "%fleet%"=="900" CALL fromEditCopy.bat "!thisManual!" "C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\swMIP_CRJ\transform\docs"

:end
EXIT

