#!/bin/bash


if [[ $1 == 'master' ]] ; then

	echo 'master'
	curl -L https://bootstrap.saltstack.com -o install_salt.sh
	sh install_salt.sh -M
	rm /etc/hostname
	touch /etc/hostname
	echo "salt" >> /etc/hostname
	systemctl restart salt-master
	systemctl restart salt-minion

elif [[ $1 == 'minion' ]] ; then 

	echo 'minion'
	curl -L https://bootstrap.saltstack.com -o install_salt.sh
	sh install_salt.sh
	sh -c "echo '10.0.7.84 salt' >> /etc/hosts"
	sh -c "echo 'master: salt' >> /etc/salt/minion"
	systemctl restart salt-minion

else

echo 'Geef master of minion op'

fi
