@echo off
		rem = information about what the following step does.
		rem - ensures that environment variables used in this script are removed from memory when the script closes
setlocal enabledelayedexpansion
		rem - Checks to see if it is ran as Administrator. If not tells you to run it as admin
net session >nul 2>&1
if %errorLevel% == 0 (
	goto start
) else (
	echo You must run this as Administrator.
	echo.
	echo After closing this window...
	echo Right-click on the Hosts_file_fixer icon
	echo Select "Run as Administrator".
	echo.
	pause
	exit
)
:start
		rem - sets the directory the Hosts file is at
set WorkDir=%windir%\system32\drivers\etc
		rem - Hosts temp file 
set imputFile=%WorkDir%\hosts.temp
		rem - tests the Hosts file for Mojang redirects
findstr /m "mojang minecraft" %WorkDir%\hosts
if %errorlevel%==0 (
		rem - hosts file needs repaired. prints the lines contains mojang redirects on screen.
cls
echo.
echo The Hosts file contains redirects for Mojang authentication.
echo.
for /f "delims=" %%A in ('findstr /i "mojang minecraft"  %WorkDir%\hosts') do (
	echo %%A
)
echo.
pause
) else (
		rem - hosts file does not need repaired
cls
echo.
echo The Hosts file does not redirect Mojang authentication.
echo You should be able to log into Minecraft: Java Edition, and Minecraft and Mojang websites.
echo If you cannot, go back into the Minecraft Discord #support channel. 
echo.
pause
exit
)
cls
echo.
echo This Batch file will attempt to correct Minecraft Login issues by removing
echo entries from the Hosts file that may be redirecting Mojang authentication.
echo.
echo ---------------------------------------------------------------
echo  f - Fix Hosts file   - removes the redirects for Minecraft
echo  e - Exit without making any changes
echo ---------------------------------------------------------------
echo.
CHOICE /C fe /N /M "Make a sellection from above: f or e"
IF ERRORLEVEL 1 SET step=repair
IF ERRORLEVEL 2 SET step=exit
goto %step%

:repair
		rem - creates the Hosts.temp file
move %WorkDir%\hosts %imputFile%
		rem - the following line reads from the Hosts.temp file and filters out all lines with mojang and minecraft
for /f "delims=" %%A in ('findstr /i /v "mojang minecraft" %imputFile%') do (
		rem - creates a new Hosts file without the lines filtered out
 echo %%A >>%WorkDir%\hosts
)
		rem - removes the Hosts.temp file
del %imputFile%
cls
echo All done, Try to sign in, if it works then chnge your password, 
echo otherwise please go back to the minecraft discord server for more support
echo.
pause

:exit
exit
