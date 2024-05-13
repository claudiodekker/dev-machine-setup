#!/bin/bash
SCRIPTPATH=$(cd "$(dirname "$0")"; pwd)

# Allow the user to determine the playbook through an environment variable
if [ -z "${playbook}" ]; then
  playbook="default"
fi

# Allow the user to pass in a password through an environment variable
# when a password is not provided, prompt the user for it.
if [ -z "${ansible_become_password}" ]; then
	read -s -p "Password: " ansible_become_password
	echo "" # Newline
fi

# If the user has not provided a password, fail.
if [ -z "$ansible_become_password" ]; then
    echo "Your sudo password is required to run this script."
    exit 1
fi

# Check if the venv folder exists
if [ ! -d "./venv" ]; then
	brew install python3
	python3 -m venv venv
fi

source ./venv/bin/activate

if ! [ -x "$(command -v ansible-playbook)" ]; then
	# Install Homebrew (if necessary)
	if ! [ -x "$(command -v brew)" ]; then
	    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
	    eval "$(/opt/homebrew/bin/brew shellenv)"
	    brew update
	fi

	# Install Ansible
	./venv/bin/pip3 install ansible
	./venv/bin/pip3 install pexpect
fi

# Actually run the playbook
ansible-playbook playbook/$playbook.yml -i playbook/hosts.yml -e "ansible_become_password=${ansible_become_password}" $@
