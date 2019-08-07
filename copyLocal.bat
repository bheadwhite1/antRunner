@ECHO OFF
SETLOCAL enabledelayedexpansion
::operate out of the same directory of this batch
PUSHD %~dp0

SET "techuserDir=C:\git\skywest-techuser"

:begin
CLS
ECHO LOCAL TRANSFORMATION AND CSS COPY
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

::  ASSIGN DATA
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

::css/js copy
ROBOCOPY "!techuserDir!\doctypes\%doctype%" "C:\techuser\doctypes\%doctype%" "%file%.css" "%file%.js" /LEV:1
::processes copy
ROBOCOPY "!techuserDir!\doctypes\%doctype%\processes" "C:\techuser\doctypes\%doctype%\processes" "aa_prepareXML.xsl" "ab_doTechview.xsl" "ac_generateTOC.xsl" "ad_finalizeXML.xsl" /LEV:1
::transform copy
ROBOCOPY "!techuserDir!\doctypes\%doctype%\common\xslt" "C:\techuser\doctypes\%doctype%\common\xslt"
GOTO begin


:end
EXIT

