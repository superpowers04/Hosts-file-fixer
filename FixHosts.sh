#!/bin/bash

# Hello, I noticed you opened this file, You might want to open it through terminal instead
# To make it executable on Linux type "chmod +x (directory to file)/FixHosts.sh"
# To run type "sudo (directory to file)/FixHosts.sh"
# You will be prompted for a password, If your typed letters/characters appear blank then that is normal
# On MacOS the Password is normally your system's password


# Made by superpowers04#3887
# With some language adjustments by JustaGhost#2197






# Checks if user has perms to hosts file or is root
if [[ $( touch /etc/hosts; echo $? ) == 1 ]] 
then
	clear

	if [[ $( zenity --error --title="Hosts File Fixer Error" --text="File needs to be run in terminal under Root!" --width=300; echo $? ) != 0 ]]
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


#Checks for the actual issue, If not found, display message below


cat /etc/hosts | grep "mojang"
if [[ $( echo $? ) == 1 ]]
 then

 	zenerr=$(zenity --info --title="Hosts File Fixer" --text="/etc/hosts is clean, No actions taken" --width 200; echo $?)
	clear
	if [[ ${zenerr} != 0 && ${zenerr} != 1  ]]
	then 
		clear
		echo "/etc/hosts is clean, No actions taken"
		echo "Press enter to exit"
		read
		exit
	else
		exit
	fi
fi


zenexicod=$(zenity --question --title="Hosts File Fixer" --text="Your Hosts file contains the following, which redirect Mojang Authentication to the IP shown\n $(cat /etc/hosts | grep "mojang")\nThis script will remove the Mojang redirects from your hosts file\n Do you want to continue?" --width=500; echo $?)
if [[ $( echo ${zenexicod} ) == 1 ]]
	then 
		exit
fi
if [[ $( echo ${zenexicod} ) != 0 ]]; then
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

	fi






read



clear
# Replaces strings

sedd1=$(sed -i "s/sessionserver.mojang.com/whywudyouvisher.com/" /etc/hosts; echo $?)
sedd2=$(sed -i "s/authserver.mojang.com/notaealrstide.swASA/" /etc/hosts; echo $?)

if [[ $sedd1 == 0 && $sedd2 == 0 ]]
then

exittext="Done.\nYou should be able to sign in now, If you can then it is recommended to change your password"
zenmessdia="info"
else
exittext="Errors might have occured, If you see any errors above please let the person helping you know\nYou should be able to sign in now, If you can then it is recommended to change your password"
zenmessdia="error"

fi
if [[ $( zenity --${zenmessdia} --title="Hosts File Fixer done!" --text="${exittext}" --width=300; echo $? ) != 0 ]]
then 
	clear
	echo "$exittext"
	echo -n "Press Enter to exit..."
	read
	exit
else
	exit
fi


