#!bin/bash

sudo apt update

sudo apt install default-jre -y

sudo apt install default-jdk -y

java -version

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt update -y

sudo apt install jenkins -y

sudo systemctl start jenkins

sudo systemctl status jenkins

sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw allow 8080
sudo ufw status
