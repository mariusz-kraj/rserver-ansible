#!/usr/bin/env bash

sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y

ansible-playbook --connection=local --inventory=/usr/share/nginx/www/app/ansible/hosts /usr/share/nginx/www/app/ansible/playbook.yml
