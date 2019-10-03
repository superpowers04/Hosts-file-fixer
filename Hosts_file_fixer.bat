		rem = information about what the following step does.
@echo off
		rem - ensures that environment vareiables used in this script are removed from mememory when the script closes
setlocal enabledelayedexpansion
		rem - Checks to see if it is ran as Administrator. If not tells you to run it as admin
net session >nul 2>&1
if %errorLevel% == 0 (
	goto set
) else (
	echo You must run this as Administrator.
	echo.
	echo After closing this window...
	echo Right-click on the Hosts_file_fixer icon
	echo Select "Run as Administrator".
	pause
	exit
)
:set
		rem - sets the directory the Hosts file is at
set WorkDir=%windir%\system32\drivers\etc
		rem - Hosts file backup file
set imputFile=%WorkDir%\hosts.bak
		rem - If hosts.bak exists, jumps to restore menu.
if exist %imputFile% (
echo hosts.bak exists in %WorkDir%
echo.
goto restore_menu
)		
:start
cls
echo.
echo This Batch file will attempt to correct Minecraft Login issues by removing
echo entries from the Hosts file that may be redirecting Mojang authentication.
echo.
echo The steps of the process are as follows
echo.
echo 1 - Renames current Hosts file to hosts.bak
echo 2 - Loads hosts.bak into memory without the lines that match the filter.
echo 3 - Writes what is in memory to a new Hosts file.
echo.
echo ---------------------------------------------------------------
echo  y - Fix Hosts file   - removes the redirects for Minecraft
echo ---------------------------------------------------------------
echo  e - Exit
echo.
CHOICE /C ye /N /M "Make a sellection"
IF ERRORLEVEL 1 SET step=repair
IF ERRORLEVEL 2 SET step=exit
goto %step%

:repair
		rem - tests the Hosts file for Mojang redirects
findstr /m "mojang minecraft" %WorkDir%\hosts
if %errorlevel%==0 (
		rem - hosts file needs repaired
cls
echo
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
echo.
pause
exit
)
		rem - creats the backup
move %WorkDir%\hosts %imputFile%
		rem - the following line reads from the backup and filters out all lines with mojang and minecraft
for /f "delims=" %%A in ('findstr /i /v "mojang minecraft" %imputFile%') do (
		rem - creats a new Hosts file without the lines filtered out
 echo %%A >>%WorkDir%\hosts
)
cls
echo All done, Try to sign in, if it works then reset your password, 
echo otherwise please go back to the minecraft discord server for more support
echo.

		rem - the following is added for replacing the new Hosts file with the one created as the backup or to delete the backup.
		rem - the following waits for a y to restore the backup HOSTS, an r to remove the backup, an n to run the fix again
:restore_menu
echo  1 - Restore Backup - replaces current Hosts file with backup 
echo  2 - Remove Backup  - deletes hosts.bak                      
echo ---------------------------------------------------------------
echo  r - Restart        - restarts the host repair process        
echo ---------------------------------------------------------------
echo  e - Exit
echo.
CHOICE /C 12re /N /M "Make a sellection"
IF ERRORLEVEL 1 SET step=restore
IF ERRORLEVEL 2 SET step=remove
IF ERRORLEVEL 3 SET step=start
IF ERRORLEVEL 4 SET step=exit
goto %step%

:restore
		rem - restores the backup by moving it to the name of "hosts"
cls
move %imputFile% %WorkDir%\hosts
echo All done restoring.
pause
goto start

:remove
		rem - deletes the backup
del %imputFile%
echo hosts.bak was deleted
pause
goto start

:exit
exit
