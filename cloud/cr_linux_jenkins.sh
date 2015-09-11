#!/bin/bash
#  This script creates a new running instance of the Linux Jenkins build server.
#  The server is configured with the last known backup of the running Linux Jenkins server.
#  The jobs from the last backup of the Linux Jenkins server are also restored.

MAXINSTANCES=20
instances=1
ask=1
if [ $# -gt 0 ]; then 
    while [ $ask -gt 0 ]; do
	echo -n "Create $1 instances, are you sure? [y/n]: "
	read ans
	case $ans in
	    [yY] | [yY][Ee][Ss] )
		instances=$1
		ask=0
		if [ $instances -gt $MAXINSTANCES ]; then
		    echo "My max limit is $MAXINSTANCES. I'll set it to $MAXINSTANCES instances."
		    instances=$MAXINSTANCES
		fi
		;;
	    [nN] | [n|N][O|o] )
		exit 1
		;;
	    *)
		echo "Just enter yes or no or Y or n or something..."
		;;
	esac
    done
fi
pushd /usr/local/accord/bin
echo "Creating ${instances} instances..."
aws ec2 run-instances --output json --image-id ami-1ecae776 --count ${instances} --instance-type t2.micro --key-name smanAWS1  --security-groups Linux-Jenkins-CI  --user-data file://setup-linux-jenkins.sh > new-linux-jenkins-instance.json
popd
date
