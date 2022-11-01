# Dev Machine Setup

This repository contains an Ansible playbook that I use to (re)configure my personal development machine. It allows me to not spend any time remembering and tweaking what my personal preferences are each time I re-install an OS or get a new device, and can take the settings with me wherever I go, taking only minutes to fully and automatically reconfigure the most fundamental parts to my liking.

## Usage
1. Adjust `playbook/default.yml` to your liking.
2. Run `ansible_become_password=<your-sudo-password-here> ./run-playbook.sh` as often as you need.

## How I use it

Whenever I decide I want to make an app, utility or (OS) setting part of my long-term default setup, _instead of manually installing it or making the change_, I adjust and re-run the playbook _until it makes the change for me_, and then commit those changes to this repository. 
I can then pull down those changes on my other machines, and re-run the playbook to apply the changes there as well. The same goes for if something accidentally gets mis-configured; I just re-run the playbook.



### What about `dotfiles`?

While both approaches achieve similar if not identical outcomes, I personally prefer Ansible playbooks for many reasons:
- Ansible is able to "test" (gather facts) and only re-configure what isn't yet in the ideal target state, saving time.
- Once you've set up your tasks and roles, it's really easy to create a different playbook (preferences file) for different types of devices, as you might not need Discord on your corporate device.
- Compared to flat bash scripts with nested if-logic, Ansible allows for organizing logic significantly very well, making it easy to add or remove changes.

In theory, you could even use Ansible as a fleet-wide remote device management solution that runs in parallel.
