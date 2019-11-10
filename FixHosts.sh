#!/bin/bash

# Hello, I noticed you opened this file, You might want to open it through terminal instead
# To make it executable on Linux type "chmod +x (directory to file)/FixHosts.sh"
# Then to run type "sudo (directory to file)/FixHosts.sh"
# You will be prompted for a password, If your typed letters/characters appear blank then that is normal
# On MacOS the Password is normally your system's password


# Made by superpowers04#3887
# With some language adjustments by JustaGhost#2197






# Checks if user has perms to hosts file or is root
if [[ $( touch /etc/hosts; echo $? ) == 1 ]] 
then
	clear

	if [[ $( zenity --error --text="File needs to be run in terminal under Root!"; echo $? ) != 0 ]]
	then 
		clear
		echo "File needs to be run as root,"
		echo "You can do this by putting 'sudo ' before the command"
		echo "If you did this then you have insufficent permissions.."
		echo "press enter to exit"
		read
		exit
	else
		exit
	fi


fi



#Cut backup restore feature, cut due to read command not working correctly

# if [[ -e "/etc/hostsbak" ]] 
# then
# 	clear
# 	echo "A backup file from a previous fix(Or restore), Would you like to restore that backup?"
# 	echo "Press enter to continue, Otherwise enter 'n' or 'no' to skip or "
# 	echo "if you don't understand what this means"
# 	read key

# 	clear
# 	echo $key
# 	if [[ "$key" -eq "n" || "$key" -eq "no" ]]
# 	then
# 		cp /etc/hosts /tmp/hostsbak
# 		cp /etc/hostsbak /etc/hosts
# 		mv /tmp/hostsbak /etc/hostsbak
# 		echo "All finished, Backup restored..."
# 		read
# 		exit
# 	fi

# fi


#Checks for the actual issue, If not found, display message below

cat /etc/hosts | grep "mojang"
if [[ $( echo $? ) == 1 ]]
 then
	clear
	echo "Hosts file is clean, No actions taken"
	echo "Press enter to exit"
	read
	exit

fi


clear
echo ""
echo "Your Hosts file contains the following, which redirect Mojang Authentication to the IP shown"
echo "---------------------------"
cat /etc/hosts | grep "mojang"
echo "---------------------------"
echo ""
echo "This script will remove the Mojang redirects from your hosts file"
echo ""
echo ""
echo -n "Press enter to continue, to exit just close out of this window or hold Ctrl and C at the same time"
read






clear
# Replaces strings
sed -i "s/sessionserver.mojang.com/whywudyouvisher.com/gI" /etc/hosts 
sed -i "s/authserver.mojang.com/notaealrstide.swASA/gI" /etc/hosts 

# All Done

echo "Done, try signing in again, If it works change your password."
echo -n "Press Enter to exit..."
read
exit
