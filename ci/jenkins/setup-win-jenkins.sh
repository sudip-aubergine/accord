#!/bin/bash
#
#  The Windows Instance: Microsoft Windows Server 2012 Base - ami-6f2cf804
#  be sure to open ports 80, 443

#  !!!!!!! NOTICE !!!!!!!
#  There is a bug in all of cygwin shells that cause it to silently truncate
#  commands longer than about 153 characters. This was causing all the 'wget'
#  and 'curl' commands to fail, even though they would work on other OS's.
#  These commands were moved to setup-win-jenkins.bat where they are working
#  correctly. If cygwin ever fixes this, we can move the lines around.

set JENKINS=jenkins-1.624.zip
set JAVAVER=jdk-8u51-windows-x64.exe
set JHOME="C:\Program Files\Java\jdk1.8.0_51"

#
# install java
#

#
# get the java sdk and install it
#
cd ~Administrator/
chmod +x jdk-8u51-windows-x64.exe
echo "Starting jdk installation..."
./jdk-8u51-windows-x64.exe /s
echo "installation complete"

#
# ensure that the windows system environment variables for JAVA
# are set up properly and that the default PATH will find the
# java programs
#
echo "Setting System environment variables JAVA_HOME and PATH..."
echo "Updating global path to include $JAVAHOME/bin"
echo "use the setx command which needs to run from a command prompt"
cmd /C setx /M JAVA_HOME "C:\Program Files\Java\jdk1.8.0_51"
cmd /C setx /M Path "%PATH%;C:\Program Files\Java\jdk1.8.0_51\bin"

#
# get the latest jenkins
#
# chmod +x unzip.exe
unzip.exe jenkins-1.624.zip