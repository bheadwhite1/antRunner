@ECHO off
SETLOCAL enabledelayedexpansion
PUSHD %~dp0
MODE con:lines=1000
:begin
::START
SET "pretty=n"
SET "fromEditCopy="
SET "search="
SET "techuserDir=C:\git\skywest-techuser"
CLS
ECHO.
ECHO      *******  PICK A DOCTYPE  *******
ECHO.
ECHO       175          200          OTHER          
ECHO   ******************************************   
ECHO    a. AMM II    t. AMM       1. MIP_CRJ        0. EXIT
ECHO    s. AIPC                   2. skybook
ECHO    d. CPM                    3. skybulletin
ECHO    f. MIP                    4. forms
ECHO    q. NDT
ECHO    w. SDS (AMM I)
ECHO    e. SRMI
ECHO    r. SRM
ECHO    z. SSM
ECHO    x. SWPM
ECHO.
CHOICE /C asdfqwerzxt12340 /CS /N /M "Pick a target: "
IF [%ERRORLEVEL%] == [1] SET "manual=175_AMM" && SET "search=MPP-SKY"
IF [%ERRORLEVEL%] == [2] SET "manual=175_AIPC" && SET "search=AIPC"
IF [%ERRORLEVEL%] == [3] SET "manual=175_CPM"
IF [%ERRORLEVEL%] == [4] SET "manual=175_MIP" && SET "search=Maintenance.*Program.*mip\)"
IF [%ERRORLEVEL%] == [5] SET "manual=175_NDT" && SET "search=swNDT_ERJ175"
IF [%ERRORLEVEL%] == [6] SET "manual=175_SDS"
IF [%ERRORLEVEL%] == [7] SET "manual=175_SRMI"
IF [%ERRORLEVEL%] == [8] SET "manual=175_SRM"
IF [%ERRORLEVEL%] == [9] SET "manual=175_SSM"
IF [%ERRORLEVEL%] == [10] SET "manual=175_SWPM"
IF [%ERRORLEVEL%] == [11] SET "manual=200_AMM"
IF [%ERRORLEVEL%] == [12] SET "manual=MIP_CRJ"
IF [%ERRORLEVEL%] == [13] SET "manual=skybook"
IF [%ERRORLEVEL%] == [14] SET "manual=skybulletin"
IF [%ERRORLEVEL%] == [15] SET "manual=forms"
IF [%ERRORLEVEL%] == [16] EXIT
IF [%manual%] == [175_AIPC] SET "doctype=swAIPC_ERJ175" && SET "file=swaipc_erj175" && SET "fromEditCopy=true"
IF [%manual%] == [175_AMM] SET "doctype=swAMM_ERJ175" && SET "file=swamm_erj175" && SET "fromEditCopy=true"
IF [%manual%] == [175_CPM] SET "doctype=swCPM_ERJ175" && SET "file=swcpm_erj175"
IF [%manual%] == [175_NDT] SET "doctype=swNDT_ERJ175" && SET "file=swndt_erj175"
IF [%manual%] == [175_MIP] SET "doctype=swMIP_ERJ175" && SET "file=swmip_erj175" && SET "fromEditCopy=true"
IF [%manual%] == [175_SDS] SET "doctype=swSDS_ERJ175" && SET "file=swsds_erj175"
IF [%manual%] == [175_SRMI] SET "doctype=swSRMI_ERJ175" && SET "file=swsrmi_erj175"
IF [%manual%] == [175_SWPM] SET "doctype=swSWPM_ERJ175" && SET "file=swswpm_erj175"
IF [%manual%] == [175_SRM] SET "doctype=swSRM_ERJ175" && SET "file=swsrm_erj175"
IF [%manual%] == [175_SSM] SET "doctype=swSSM_ERJ175" && SET "file=swssm_erj175"
IF [%manual%] == [200_AMM] SET "doctype=swAMM_CRJ200" && SET "file=swamm_crj200"
IF [%manual%] == [200_MIP] SET "doctype=swMIP_CRJ" && SET "file=swmip_crj"
IF [%manual%] == [700_MIP] SET "doctype=swMIP_CRJ" && SET "file=swmip_crj"
IF [%manual%] == [900_MIP] SET "doctype=swMIP_CRJ" && SET "file=swmip_crj"
IF [%manual%] == [MIP_CRJ] SET "doctype=swMIP_CRJ" && SET "file=swmip_crj" && SET "fromEditCopy=true"
IF [%manual%] == [skybook] SET "doctype=skybook" && SET "file=skybook"
IF [%manual%] == [skybulletin] SET "doctype=skybulletin" && SET "file=skybulletin"
IF [%manual%] == [forms] SET "doctype=swForms_MX" && SET "file=swforms_mx"
IF [%manual%] == [sw] SET "doctype=sw"
GOTO build

:build
::SET LOCATION OF INPUT FILES 

SET "manInputDir=!techuserDir!\doctypes\%doctype%\transform\docs"
IF [%doctype%] == [skybook] SET "manInputDir=C:\Users\s064075\Desktop\xmlDocs\%doctype%\src"
IF [%doctype%] == [skybulletin] SET "manInputDir=C:\Users\s064075\Desktop\xmlDocs\%doctype%\src"

::SET skywest revision docs
SET "skydocs=transform\docs"
IF [%doctype%] == [swAIPC_ERJ175] SET "skydocs=processes\docs"
IF [%doctype%] == [swAMM_ERJ175] SET "skydocs=processes\docs"

:manual
::SELECT A MANUAL
CLS
SET /a counter=0
SET stop=0
SET choicer=
IF [%fromEditCopy%] == [true] (
    IF [!manual!] == [MIP_CRJ] (
        ECHO   ******* PICK A FLEET *******
        ECHO.
        ECHO  1. 200
        ECHO  2. 700
        ECHO  3. 900
        ECHO.
        CHOICE /C 123 /CS /N /M "Pick a target: "
        IF [!ERRORLEVEL!] == [1] SET "search=CRJ.*200" && SET "manual=200-MIP" && SET "TUdoctype=swMIP_CRJ200"
        IF [!ERRORLEVEL!] == [2] SET "search=CRJ.*700.*MIP" && SET "manual=700-MIP" && SET "TUdoctype=swMIP_CRJ700"
        IF [!ERRORLEVEL!] == [3] SET "search=CRJ.*900.*MIP" && SET "manual=900-MIP" && SET "TUdoctype=swMIP_CRJ900"
    )
)
::copy in from fromEditor to \processes\docs or \transform\docs
IF [%fromEditCopy%] == [true] (
    REM FOR /f "usebackq delims=|" %%f in (`dir /B /A:-D /O:-D "\\sgudocstage\Documents\JaredLisa\skytrackprocess\src\fromEditor"`) do (
    FOR /f "usebackq delims=|" %%f in (`dir /B /o-d /tc "\\sgudocstage\Documents\JaredLisa\skytrackprocess\src\fromEditor"`) do (
        IF !stop! LSS 15 (
            SET /a stop+=1
            ECHO %%f | findstr /r "!search!" >NUL
            IF NOT ERRORLEVEL 1 (
                set "copied=yes"
                CALL fromEditCopy.bat "%%f" "!techuserDir!\doctypes\!doctype!\!skydocs!"
            )
        )
    )
    REM set search to blank for doctypes that use a supplement
    IF [!copied!] == [yes] set "copied=" && pause
    IF [!doctype!] == [swAIPC_ERJ175] SET "search="
    IF [!doctype!] == [swAMM_ERJ175] SET "search="
)

:displayManuals
::display manuals in \transform\docs
CLS
ECHO.
ECHO     ******* PICK A MANUAL *******
ECHO.
IF [%search%] == [] (
    FOR /f "usebackq delims=|" %%f in (`dir /B /o-d /tc %manInputDir%`) do (
        ECHO %%f | findstr /v /r "xPath" >NUL
        IF NOT ERRORLEVEL 1 (
            SET /a counter+=1
            ECHO !counter!: %%f
            SET choicer[!counter!]=%%f
        )
    )
) ELSE (
    FOR /f "usebackq delims=|" %%f in (`dir /B /o-d /tc %manInputDir%`) do (
        ECHO %%f | findstr /v /r "xPath" | findstr /r "!search!" >NUL
        IF NOT ERRORLEVEL 1 (
            SET /a counter+=1
            ECHO !counter!: %%f
            SET choicer[!counter!]=%%f
        )
    )

)

IF !counter!==0 CLS && ECHO. && ECHO nothing setup for this doctype. Try Again. && ECHO. && PAUSE && GOTO begin
IF !counter!==1 SET "num=1" && GOTO onlyone
ECHO.
SET /p num="Pick a target or b to go back: "
IF [%num%] == [b] GOTO begin
:onlyone
SET thisManual=!choicer[%num%]!
SET choicer=docs\!thisManual!
GOTO viewfile
:antrunner
::SELECT A TARGET TO RUN IN ANTRUNNER

CLS
ECHO.
ECHO                      ******* ANTRUNNER *******
ECHO            doctype - %doctype%  Manual - %thisManual% 
ECHO.
ECHO a. [RUN]basic  q. [DEPLOY]     z. [RUN]reports   p. copy path       n. new doctype     
ECHO s. convert     w. makeHTML                       g. local graphics  m. new manual
ECHO d. addTOC      e. doShort                        y. buildMIPfleet   v. view Files
ECHO f. finalize    r. [RUN]short                                        x. xPath
ECHO.
CHOICE /C asdfqwerzxvmnpgy /N /M "Pick a target: "
IF [%ERRORLEVEL%] == [1] SET target=[RUN]basic
IF [%ERRORLEVEL%] == [2] SET target=[ride-init]basic
IF [%ERRORLEVEL%] == [3] SET target=[ride-temp]basic
IF [%ERRORLEVEL%] == [4] SET target=[ride-final]basic
IF [%ERRORLEVEL%] == [5] SET target=[DEPLOY]
IF [%ERRORLEVEL%] == [6] SET target=makeHTML
IF [%ERRORLEVEL%] == [7] SET target=short-deploy && GOTO runSHORT
IF [%ERRORLEVEL%] == [8] SET target=[RUN]short && GOTO runSHORT
IF [%ERRORLEVEL%] == [9] SET target=[RUN]reports
IF [%ERRORLEVEL%] == [10] GOTO xpath
IF [%ERRORLEVEL%] == [11] GOTO viewfile
IF [%ERRORLEVEL%] == [12] GOTO manual
IF [%ERRORLEVEL%] == [13] GOTO begin
IF [%ERRORLEVEL%] == [14] (
    ECHO "!techuserDir!\doctypes\%doctype%\transform\src" | clip
    GOTO antrunner
)
IF [%ERRORLEVEL%] == [15] GOTO localGraphics
IF [%ERRORLEVEL%] == [16] GOTO buildMIPfleet

:runANT
::RUN TARGET

CLS
ECHO "!techuserDir!\doctypes\%doctype%\transform\src" | clip
start runANT.bat "%thisManual%" "%doctype%" "%target%"
GOTO viewfile

:viewfile
::VIEW FILE IN FOXE
CLS
ECHO.
ECHO                       ******* FILE VIEWER *******
ECHO               doctype - %doctype%     Manual - %thisManual%
ECHO.
ECHO a. clean (prepare)         q. original     c. runANT (same target)     n. new doctype
ECHO s. init (convert)          w. html         p. copy path                m. new manual
ECHO d. temp (addTOC)           r. short        1. copy Local Styles        u. AntRunner 
ECHO f. reloaded (finalize)                                                 x. xPath
ECHO.

CHOICE /C asdfqwrxcumnp1 /N /CS /M "Pick a target%pmsg%: "
IF [%ERRORLEVEL%] == [1] SET choicer=tmp\!thisManual:~0,-4!-clean.xml
IF [%ERRORLEVEL%] == [2] SET choicer=tmp\!thisManual:~0,-4!-init.xml
IF [%ERRORLEVEL%] == [3] SET choicer=tmp\!thisManual:~0,-4!-temp.xml
IF [%ERRORLEVEL%] == [4] SET choicer=tmp\!thisManual:~0,-4!-reloaded.xml
IF [%ERRORLEVEL%] == [5] (
    SET choicer=docs\!thisManual!
    IF [%doctype%] == [skybook] START "C:\Program Files\firstobject\foxe.exe" "!manInputDir!\!thisManual!" && GOTO viewFile
    IF [%doctype%] == [skybulletin] START "C:\Program Files\firstobject\foxe.exe" "!manInputDir!\!thisManual!" && GOTO viewFile
)
IF [%ERRORLEVEL%] == [6] SET choicer=tmp\!thisManual:~0,-4!.html
IF [%ERRORLEVEL%] == [7] SET choicer=tmp\!thisManual:~0,-4!-short.xml
IF [%ERRORLEVEL%] == [8] GOTO xpath
IF [%ERRORLEVEL%] == [9] GOTO runANT
IF [%ERRORLEVEL%] == [10] GOTO antrunner
IF [%ERRORLEVEL%] == [11] GOTO manual
IF [%ERRORLEVEL%] == [12] GOTO begin
IF [%ERRORLEVEL%] == [13] ECHO "!techuserDir!\doctypes\%doctype%\transform\src" | clip && GOTO viewfile
IF [%ERRORLEVEL%] == [14] GOTO copyLocal
REM IF [%ERRORLEVEL%] == [15] (
REM     IF [!pretty!] == [n] (
REM         SET "pretty=y" && SET "pmsg= (pretty)" && GOTO viewfile
REM     )
REM     IF [!pretty!] == [y] (
REM         SET "pretty=n" && SET "pmsg=" && GOTO viewfile
REM     )
REM )
REM IF [%pretty%] == [n] START "C:\Program Files\firstobject\foxe.exe" "!techuserDir!\doctypes\%doctype%\transform\!choicer!"
REM IF [%pretty%] == [y] (
REM     tidy -xml --indent auto --indent-attributes yes --indent-spaces 10 --uppercase-tags yes "!techuserDir!\doctypes\%doctype%\transform\!choicer!" > "C:\Users\s064075\Desktop\temp\!choicer!"
REM     START "C:\Program Files\firstobject\foxe.exe" "C:\Users\s064075\Desktop\temp\!choicer!"
REM )
START "C:\Program Files\firstobject\foxe.exe" "!techuserDir!\doctypes\%doctype%\transform\!choicer!"

GOTO viewfile

:xpathMenu

CLS
ECHO.
ECHO                    ******* SELECT NEW TARGET FILE *******
ECHO            CURRENT TARGET: %choicer%
ECHO.
ECHO a. !thisManual:~0,-4!-clean.xml               n. new doctype
ECHO s. !thisManual:~0,-4!-init.xml                m. new manual                
ECHO d. !thisManual:~0,-4!-temp.xml                u. antrunner
ECHO f. !thisManual:~0,-4!-reloaded.xml            v. view files
ECHO w. !thisManual:~0,-4!.html
ECHO r. !thisManual:~0,-4!-short.xml
ECHO.
ECHO Select a file to run an xpath query on.
CHOICE /C asdfwrvumn /N /CS /M "Pick a target: "
IF [%ERRORLEVEL%] == [1] SET choicer=tmp\!thisManual:~0,-4!-clean.xml && SET "customXpath=y" && GOTO runxpath
IF [%ERRORLEVEL%] == [2] SET choicer=tmp\!thisManual:~0,-4!-init.xml && SET "customXpath=y" && GOTO runxpath
IF [%ERRORLEVEL%] == [3] SET choicer=tmp\!thisManual:~0,-4!-temp.xml && SET "customXpath=y" && GOTO runxpath
IF [%ERRORLEVEL%] == [4] SET choicer=tmp\!thisManual:~0,-4!-reloaded.xml && SET "customXpath=y" && GOTO runxpath
IF [%ERRORLEVEL%] == [5] SET choicer=tmp\!thisManual:~0,-4!.html && SET "customXpath=y" && GOTO runxpath
IF [%ERRORLEVEL%] == [6] SET choicer=tmp\!thisManual:~0,-4!-short.xml && SET "customXpath=y" && GOTO runxpath
IF [%ERRORLEVEL%] == [7] GOTO viewfile
IF [%ERRORLEVEL%] == [8] GOTO antrunner
IF [%ERRORLEVEL%] == [9] GOTO manual
IF [%ERRORLEVEL%] == [10] GOTO begin

:xpath
SET choicer=docs\!thisManual!
SET "customXpath="
:runxpath
CLS
ECHO.
ECHO                    ******* XPATH RUNNER *******
ECHO               TARGET: %choicer%
ECHO.
ECHO x. xpath on temp files            n. new doctype
ECHO p. [RUN]basic on new file         m. new manual
ECHO o. custom root                    u. antrunner
ECHO c. chapter                        v. view files
ECHO.
SET /p expression="enter xpath to generate new file: "
IF [!expression!] == [x] GOTO xpathMenu
IF [!expression!] == [v] GOTO viewfile
IF [!expression!] == [u] GOTO antrunner
IF [!expression!] == [m] GOTO manual
IF [!expression!] == [n] GOTO begin
IF [!expression!] == [p] SET "thisManual=%manual%xPath.xml" && SET "target=[RUN]basic" && GOTO runANT
SET "root=!techuserDir!\doctypes\%doctype%"
SET "dtd=%root%\%doctype%.dtd"
SET thisFile="%root%\transform\!choicer!"
IF [!expression!] == [c] GOTO runchapters
IF [!expression!] == [o] GOTO xpathWithRoot
::working
IF [%customXpath%] == [y] (
    ECHO performing %expression% on this file: !choicer! ...
    xml sel -t -c "!expression!" !thisFile! >  %root%\transform\docs\%manual%xPath.xml
    GOTO launchxpathfile
)
ECHO running doctype entities
tidy -q -xml !thisFile! | findstr /R "?xml DOCTYPE ENTITY dtd \]> ^\[$" > %root%\transform\docs\%manual%xPath.xml
REM tidy -q -xml --doctype omit --numeric-entities yes !thisFile! | xml sel -t -c "%expression%"  >>  %root%\transform\docs\xPath.xml
ECHO running xpath
xml -q fo -D !thisFile! | tidy -q -xml | xml sel -t -c "%expression%"  >>  %root%\transform\docs\%manual%xPath.xml
:launchxpathfile
START %root%\transform\docs\%manual%xPath.xml
GOTO xpath

:xpathWithRoot
SET /p xpathroot="enter the name of new root element: "
SET /p expression="enter xpath to transform body of new root: "
IF [!expression!] == [x] GOTO xpathMenu
IF [!expression!] == [v] GOTO viewfile
IF [!expression!] == [u] GOTO antrunner
IF [!expression!] == [m] GOTO manual
IF [!expression!] == [n] GOTO begin
IF [!expression!] == [p] SET "thisManual=%manual%xPath.xml" && SET target=[RUN]basic && GOTO runANT

tidy -q -xml !thisFile! | findstr /R "?xml DOCTYPE ENTITY dtd \]> ^\[$" > %root%\transform\docs\%manual%xPath.xml
xml -q fo --dropdtd !thisFile! | tidy -q -xml | xml sel -t -e "%xpathroot%" -c "%expression%[1]" >> %root%\transform\docs\%manual%xPath.xml
START %root%\transform\docs\%manual%xPath.xml
GOTO xpath

:runchapters
SET /p chKey="what chapter?: "
xml -q fo -D !thisFile! | tidy -q -xml | xml tr "runChapters.xsl" -s chKey=%chKey% > %root%\transform\docs\%manual%xPath.xml
START %root%\transform\docs\%manual%xPath.xml
GOTO xpath

:runSHORT
SET "shortChapters="
ECHO precede special chars with a "^"
SET /p shortChapters="enter chapters for %manual% short (b=back)"
IF [!shortChapters!] == [b] GOTO antrunner
ECHO "!techuserDir!\doctypes\%doctype%\transform\src" | clip
IF [!manual!] == [175_MIP] GOTO runSHInspections
IF [!manual!] == [MIP_CRJ] GOTO runSHInspections 
IF [!manual!] == [700-MIP] GOTO runSHInspections 
IF [!manual!] == [900-MIP] GOTO runSHInspections 
IF [!manual!] == [200-MIP] GOTO runSHInspections
::SHORT CHAPTER
REM "thisManual" "chapters" "doctype" "target"
START short.bat "!thisManual!" "!shortChapters!" "!doctype!" "!target!"
GOTO viewfile
::SHORT CHAPTER / INSPECTIONS (MIPs)
:runSHInspections
SET /p shortInspections="enter inspections for short (b=back)"
IF [%shortInspections%] == [b] GOTO antrunner
START shortInspec.bat "!thisManual!" "!shortChapters!" "!doctype!" "!target!" "!shortInspections!"
GOTO viewfile


:buildMIPfleet
CALL ant "-Dpname1=build.dir" "-Dvalue1=all Fleets" "-Dpname2=current.fleets" "-Dvalue2=swMIP_CRJ200,swMIP_CRJ700,swMIP_CRJ900" "-DinputManual=I am just developing a build..." -f !techuserDir!\doctypes\swMIP_CRJ\transform\apache.ant [DEVELOP]buildForIndividualFleets
START /b "" CSCRIPT alert.vbs "MIP fleet is complete" "build MIP fleet"
pause
GOTO antrunner

:localGraphics
::DISTRIBUTE GRAPHICS LOCALLY
SET "localLib=C:\techuser\data\OO_MX"
:bookfolder
SET /a counter=0
SET "num="
ECHO path: !localLib!
FOR /f "usebackq delims=|" %%f in (`dir /b %localLib%`) do (
    ::if you find graphic/xml strings add to bookFolderPath; if bfp is >1 we found bfp and can exit the folder sequence engine
    ECHO %%f | findstr /r "^graphic ^xml">NUL
    IF NOT ERRORLEVEL 1 (
        SET /a bfp+=1
        IF !bfp! GTR 1 (
            GOTO bfp
        )
    )
)
FOR /f "usebackq delims=|" %%f in (`dir /b %localLib%`) do (
    ECHO %%f | findstr /r "^.gitignore ^techsuite.*.db ^icon" >NUL
    IF ERRORLEVEL 1 (
        SET /a counter+=1
        ECHO !counter!: %%f
        SET choicer[!counter!]=%%f
    )
)
IF [%counter%] == [1] SET "folder=\!choicer[1]!" && GOTO folderset
SET /p num="choose a folder: "
IF [%num%] == [b] GOTO antrunner
CLS
SET "folder=\!choicer[%num%]!"
:folderset
SET "localLib=!localLib!%folder%"
GOTO bookfolder

:bfp
call ant -Dbookfolder=!localLib! -file C:\techuser\doctypes\!TUdoctype!\build.xml [DIST.LOCAL]
START /b "" CSCRIPT alert.vbs "the bfp ant is complete" "BFP"
pause
GOTO antrunner

:copyLocal
IF [!ERRORLEVEL!] == [1] SET "search=CRJ.*200" && SET "manual=200-MIP" && SET "TUdoctype=swMIP_CRJ200"
IF [!ERRORLEVEL!] == [2] SET "search=CRJ.*700.*MIP" && SET "manual=700-MIP" && SET "TUdoctype=swMIP_CRJ700"
IF [!ERRORLEVEL!] == [3] SET "search=CRJ.*900.*MIP" && SET "manual=900-MIP" && SET "TUdoctype=swMIP_CRJ900"
IF [!manual!] == [200-MIP] CALL copyLocal2.bat "!techuserDir!" "!TUdoctype!" "!file!" && GOTO viewFile
IF [!manual!] == [700-MIP] CALL copyLocal2.bat "!techuserDir!" "!TUdoctype!" "!file!" && GOTO viewFile
IF [!manual!] == [900-MIP] CALL copyLocal2.bat "!techuserDir!" "!TUdoctype!" "!file!" && GOTO viewFile
CALL copyLocal2.bat "!techuserDir!" "!doctype!" "!file!"
GOTO viewFile

:end