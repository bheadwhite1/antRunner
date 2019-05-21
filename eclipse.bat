mode con:cols=300 lines=1000
call ant -DinputManual=%1 -Dpname=%4 -Dchapters=%5 -buildfile C:\Git\SkyWestAirlines\skywest-techuser-44\doctypes\%~n3\transform\apache.ant [RUN]basic
:popalert
set timerMSG="%~n2 eclipse processing is finished, ready to publish?"
set titlebarMSG=eclipse
start /b "" cscript alert.vbs %timerMSG% %titlebarMSG%
pushd %~dp0
pause
