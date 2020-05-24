@echo off
set first=%time%
@setlocal ENABLEDELAYEDEXPANSION

:: SETTINGS
set "echo_cmd=y"

:: checking for help
if [%1]==[help] ( goto help )
if [%1]==[/?] ( goto help )


:: checking for commands
set count=0
:loop
if [%1]==[] goto endloop
:: record command
echo. & set /a count=%count% + 1 & set cmd=%1& set cmd=!cmd:"=!
set start=%time%

if defined echo_cmd ( %cmd% ) else ( %cmd%>nul )

set end=%time%
call :calc %start% %end% & shift
goto loop
:endloop
if "%count%"=="0" ( echo  Declare an argument^! & exit /b 1 )
echo. & echo ______________________________
set cmd=This& call :calc %first% %time% & exit /b 0


:: help menu
:help
echo.
echo  simply input your commands as arguments,
echo  each inclosed in ""
echo.
echo  ^& if you want to include a command that has quotations in it, you'll need to do some trickery like this:
echo  cmd /v:on /c set ^^^^^"q=^^^^^"^^^^^" ^& %~nx0 "cmd /c ^^^!q^^^!exit /b 0^^^!q^^^!"
echo.
echo  -Alex
echo.
exit /b 0


:: records time delta
:calc
set options="tokens=1-4 delims=:.,"
for /f %options% %%a in ("%1") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%2") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%
if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %hours% lss 0 set /a hours = 24%hours%
if 1%ms% lss 100 set ms=0%ms%

:: mission accomplished
set /a totalsecs = %hours%*3600 + %mins%*60 + %secs%
echo %cmd% took %hours%:%mins%:%secs%.%ms% (%totalsecs%.%ms%s total)
exit /b 0

:: Enjoy! :)

:: Sincerely, Alex
::::  https://github.com/alexlyee
