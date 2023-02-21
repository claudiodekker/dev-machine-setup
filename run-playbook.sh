#!/bin/bash
SCRIPTPATH=$(cd "$(dirname "$0")"; pwd)

if [ -z "${ansible_become_password}" ]; then
	echo "Please provide your sudo-password as an environment variable. For example:"
	echo "$ ansible_become_password=foo ./run-playbook.sh";
	exit 1
fi

if ! [ -x "$(command -v ansible-playbook)" ]; then
	# Install Homebrew (if necessary)
	if ! [ -x "$(command -v brew)" ]; then
	    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	    brew update
	fi

	# Install Ansible
	brew install python3
	pip3 install ansible
	pip3 install pexpect
fi

# Actually run the playbook
ansible-playbook playbook/default.yml -i playbook/hosts.yml -e "ansible_become_password=${ansible_become_password}" $@
