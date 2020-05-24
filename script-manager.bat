set "V=1.4"
set "ProgramV=%V%"
@echo off
cls
REM ETools kit
set "_e=!" & set "_p=%" & set "_s= "
REM =====================================================================ADMIN PERMISSIONS SCRIPT START
IF '%PROCESSOR_ARCHITECTURE%' EQU 'amd64' (
   >nul 2>&1 "%SYSTEMROOT%\SysWOW64\icacls.exe" "%SYSTEMROOT%\SysWOW64\config"
 ) ELSE (
   >nul 2>&1 "%SYSTEMROOT%\system32\icacls.exe" "%SYSTEMROOT%\system32\config"
)
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
REM =====================================================================ADMIN PERMISSIONS SCRIPT END
set "THECD=C:\Users\Alex\Desktop\Projects\HelpfulBatch"
cd /D "%THECD%"
title Choose Your System!
set V_temp=%V% & set ProgramV_temp=%ProgramV%
setlocal EnableDelayedExpansion EnableExtentions
:Start
cls
set "targetfiles=%CD%\files" & set "targetfiles2=%CD%\files\*" & set "dotcount=1" & set "offset=1" & set "count2=0" & set "count=0"
echo.
echo  -- All the programs below are apart of my Workspace system!_e! :P --
echo.
echo.
echo.
echo  0 - Workspace System
echo ..... View the system's options.
echo .......... V%V%
echo.
echo.
:repeat
if /I {!count_%offset%!}=={} (set "count_%offset%=0")
set "count2=!count_%offset%!" & set "dots=" & set "skipped=" & set /a "skip=%offset% - 1" & set "count3=0"
for /L %%A in (1,1,%offset%) do (set "dots=!dots!.....")
for /L %%A in (1,1,%skip%) do (set "skipped=!skipped!     ")
 REM count3 is the count of this for loop.
  REM count2 is the count of this specific folder's number WITHIN it's dir.
   REM count is the count of this specific folder's number within the WHOLE.
for /f "delims=" %%A in ('dir /b "!targetfiles2!"') do (
	set /a "count3=!count3! + 1"
	if !count3! GTR !count2!  (
		set /a "count2=!count2! + 1"
		set /a "count=!count! + 1"
		set "count_!offset!=!count2!"
		set Option!count!=!targetfiles!\%%~nA
		if !offset! GTR 1 (
			for /L %%A in (1,1,!offset!) do (
				set "offset3=!offset3!!count_%%A!"
				if NOT %%A EQU !offset! (
					set "offset3=!offset3! ^> "
				)
			)
			set "offset3=!offset3! "
		)
		set "echo0=echo !skipped! [!count!] !offset3!// %%~nA"
		set "offset3="
		set targetdir=!targetfiles!\%%~nA
		if EXIST "!targetdir!\brief.txt" (
			set Condition1=true
			set /p texte=< "!targetdir!\brief.txt"
			set "echo1=echo  !dots! !texte!"
		) else set "Condition1=false" & set "echo1="
		if EXIST "!targetdir!\main.bat" (
			set Condition2=true
			set /p Line1=< "!targetdir!\main.bat"
			set "V=" & set "ProgramV="
			!Line1!
			set V=!V_temp! & set "Line1="
		) else set "Condition2=false" & set "echo2="
		if EXIST "!targetdir!\V.txt" (
			set Condition3=true
			set /p Line1=< "!targetdir!\V.txt"
			if /I NOT {!echo2!}=={} set "echo2=!echo2! Program V!Line1!"
		) else set "Condition3=false" & set "echo2=!echo2!"
		!echo0!
		!echo1!
		!echo2!
		if /I {!Condition2!}=={false} (echo  --- This Is ^Not Compatible With Workspace V!V!!_e!)
		REM Detect next number or previous, where left off, and 
		if EXIST "!targetdir!\files\" (
			set /a "offset=!offset! + 1"
			set "count_!offset!=0"
			set "targetfiles=!targetdir!\files"
			set "targetfiles2=!targetdir!\files\*"
			echo.
			goto :repeat
		)
		REM if its here its done with the list for that section.
		if !offset! GTR 1 (
			set /a "offset2=!offset! - 1"
			cd /D "!targetfiles!"
			cd.. & cd.. & set "targetfiles=!CD!"
			set "targetfiles2=!CD!\*"
			set "count_!offset!=%count_!offset2!%"
			set "offset=!offset2!"
			set "offset2="
			echo.
			goto :repeat
		)
		echo.
		cd /D "%THECD%"
	)
)
echo.
echo.
echo.
echo  Enter choice: in []
echo.
set /p onetwo=" - "
if NOT %onetwo%==0 (goto :skippy)
cls
echo.
echo  This is my workspace system.
echo  All folders within (file) are used as the title of the program they contain.
echo  The program uses the title main.bat, always.
echo  It may also use V.txt and put the program version in there.
echo  And brief.txt can be used to describe the program.
echo.
echo  Now, within each program there can be another folder called file.
echo  In which case it exists within that program it will be scanned just like the main (file) folder.
echo  This allows for programs to effectively have sets of programs within them, infinitly, but that won't happen.
echo  Here is a visual on the directory tree structure of this system:
echo.
for /F "skip=5 delims=" %A in ('tree "%THECD%" /F') do (echo  - %A)
echo.
pause
goto :Start
:skippy
REM =====================================================================START VAR MANAGER SCRIPT
set EXEPTION1=EXEPTIONS
set EXEPTION2=Option%onetwo%
set EXEPTION3=onetwo
set NumberOfExeptions=3
set Output=false
REM Set Output to true, for the spam ;)
REM It deletes all variables, and you can apply one's to not by putting them above.
if /I {%Output%}=={true} (
	echo Cleaning Variables. . .
	echo.
	echo Exeptions:
	for /L %%A in (1,1,%NumberOfExeptions%) do (echo .... "!EXEPTION%%A!")
	echo.
)
for /f "tokens=1,2 delims==" %%A in ('set') do (
	set "skip="
	for /L %%B in (1,1,%NumberOfExeptions%) do (
		if /I {%%A}=={!EXEPTION%%B!} (set "skip=1")
		if /I {%%A}=={EXEPTION%%B} (set "skip=1")
		if /I {%%A}=={NumberOfExeptions} (set "skip=1")
		if /I {%%A}=={Output} (set "skip=1")
	)
	if NOT !skip!==1 (
		if /I {%Output%}=={true} (echo Removing Enviorment Variable "%%A" . . .)
		set "%%A="
	)
)
for /L %%A in (1,1,%NumberOfExeptions%) do (set "EXEPTION%%A=")
if /I {%Output%}=={true} (echo. & echo Done Cleaning Variables.)
set "EXEPTIONS=" & set "NumberOfExeptions=" & set "Output=" & set "NumberOfExeptions="
REM =====================================================================END VAR MANAGER SCRIPT
@echo on
cls
call "!Option%onetwo%!\main.bat" "!Option%onetwo%!"
set "Option%onetwo%=" & set "onetwo="
exit /B





REM Testing below. . . . . . . . . . . . . . . . . . . . . . . . . . . . .


:repeat2
REM This script is a compacted version of the batch manager script.
if /I {!count_%offset%!}=={} (set "count_%offset%=0")
set "count2=!count_%offset%!" & set "dots=" & set "skipped=" & set /a "skip=%offset% - 1" & set "count3=0" & for /L %%A in (1,1,%offset%) do (set "dots=!dots!.....")  & & set "targetfiles2=%CD%\files\*" & for /L %%A in (1,1,%skip%) do (set "skipped=!skipped!     ")
for /f "delims=" %%A in ('dir /b "!targetfiles2!"') do (set /a "count3=!count3! + 1"
	if !count3! GTR !count2!  (set /a "count2=!count2! + 1" & set /a "count=!count! + 1" & set "count_!offset!=!count2!" & set Option!count!=!targetfiles!\%%~nA
		if !offset! GTR 1 (for /L %%A in (1,1,!offset!) do (set "offset3=!offset3!!count_%%A!" & if NOT %%A EQU !offset! (set "offset3=!offset3! ^> ")) & set "offset3=!offset3! ")
		set "echo0=echo !skipped! [!count!] !offset3!// %%~nA" & set "offset3=" & set "targetdir=!targetfiles!\%%~nA"
		if EXIST "!targetdir!\brief.txt" (set Condition1=true & set /p texte=<"!targetdir!\brief.txt" & set "echo1=echo  !dots! !texte!") else set "Condition1=false" & set "echo1="
		if EXIST "!targetdir!\main.bat" (set Condition2=true & set /p Line1=<"!targetdir!\main.bat" & set "V=" & set "ProgramV=" & !Line1! & set "echo2=echo  !dots!..... Using Workspace V!V!" & set V=!V_temp! & set "Line1=") else set "Condition2=false" & set "echo2="
		if EXIST "!targetdir!\V.txt" (set Condition3=true & set /p Line1=<"!targetdir!\V.txt" & if /I NOT {!echo2!}=={} set "echo2=!echo2! Program V!Line1!") else set "Condition3=false" & set "echo2=!echo2!"
		!echo0!
		!echo1!
		!echo2!
		if /I {!Condition2!}=={false} (echo  --- This Is ^Not Compatible With Workspace V!V!!_e!)
		if EXIST "!targetdir!\files\" (set /a "offset=!offset! + 1" & set "count_!offset!=0" & set "targetfiles=!targetdir!\files" & set "targetfiles2=!targetdir!\files\*" & echo. & goto :repeat2)
		if !offset! GTR 1 (set /a "offset2=!offset! - 1" & cd /D "!targetfiles!" & cd.. & cd.. & set "targetfiles=!CD!" & set "targetfiles2=!CD!\*" & set "count_!offset!=%count_!offset2!%" & set "offset=!offset2!" & set "offset2=" & echo. & goto :repeat2)
		echo. & cd /D "%THECD%"
		)
		)
set "offset=" & set "offset2=" & set "offset3=" & set "dotcount=" & set "dots=" & set "echo0=" & set "echo1=" & set "echo2=" & set "Condition1=" & set "Condition2=" & set "Condition3=" & set "count=" & set "count2=" & set "count3=" & set "targetfiles2=" & set "count_1=" & set "skip=" & set "skipped=" & set "V_temp="


:: Enjoy! :)

:: Sincerely, Alex
::::  https://github.com/alexlyee

