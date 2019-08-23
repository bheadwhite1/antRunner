@ECHO OFF
SETLOCAL enabledelayedexpansion

REM TESTING
REM ECHO "%~1\doctypes\%~2" "C:\techuser\doctypes\%~2" "%~3.css" "%~3.js"
REM pause

ROBOCOPY "%~1\doctypes\%~2" "C:\techuser\doctypes\%~2" "%~3.css" "%~3.js" "%~2html.xsl" /LEV:1
::processes copy
ROBOCOPY "%~1\doctypes\%~2\processes" "C:\techuser\doctypes\%~2\processes" "aa_prepareXML.xsl" "ab_doTechview.xsl" "ac_generateTOC.xsl" "ad_finalizeXML.xsl" /LEV:1
::transform copy
ROBOCOPY "%~1\doctypes\%~2\common\xslt" "C:\techuser\doctypes\%~2\common\xslt"


:end

