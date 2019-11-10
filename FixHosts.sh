# Hello, I noticed you opened this file, You might want to open it through terminal instead
# To make it executable on Linux type "chmod +x (directory to file)/FixHosts.sh"
# Then to run type "sudo (directory to file)/FixHosts.sh"
# You will be prompted for a password, If your typed letters/characters appear blank then that is normal
# On MacOS the Password is normally your system's password


# Made by superpowers04#3887



# Checks if user has perms to hosts file or is root
if [[ $( touch /etc/hosts; echo $? ) == 1 ]] 
then
	clear
	echo "File needs to be run as root,"
	echo "You can do this by putting 'sudo ' before the command"
	echo "If you did this then you have insufficent permissions.."
	echo "press enter to exit"
	read
	exit


fi

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

echo "This script will hopefully fix logging in, It will backup your hosts file"
echo "Press enter to continue, to exit just close out of this window"
echo ""
echo ""
echo ""
echo "If interested, you can see the lines below"
echo "---------------------------"
cat /etc/hosts | grep "mojang"
echo "---------------------------"





read

clear
# Replaces strings
sed -i "s/sessionserver.mojang.com/whywudyouvisher.com/gI" /etc/hosts 
sed -i "s/authserver.mojang.com/notaealrstide.swASA/gI" /etc/hosts 

# All Done

echo "Done, try signing in again, If it works change your password at https://minecraft.net"
echo "If this file has damaged anything just reopen terminal and type "
echo "'sudo cp /etc/hostsbak /etc/hosts'."
echo "Press Enter to exit..."
read
exit
