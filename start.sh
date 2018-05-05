#!/bin/bash
echo -e "\e[38;5mEnabling universe, updating and upgrading.....\e[38;5m"
sudo add-apt-repository universe
sudo apt-get -y update && sudo apt-get -y upgrade

echo -e "\e[38;5mInstalling git and salt-master\e[38;5m"
sudo apt-get -y install git salt-master
echo -e "\e[38;5;82mCloning git repo\e[38m"
git clone https://github.com/robado/live-usb-configuration
cd live-usb-configuration/

echo -e "\e[38;5mInstalling git repo modules\e[38;5m"
./highstate.sh && cd
echo -e "\e[38;5mOpening terminals and gtop in one of them\e[38;5m"
./terminal.sh

echo -e "Exiting......"
exit
