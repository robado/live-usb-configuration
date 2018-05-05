#!/bin/bash
echo -e "\e[38;5;82mEnabling universe, updating and upgrading.....\e[38;5;82m"
sudo add-apt-repository universe
sudo apt-get update && sudo apt-get upgrade

echo -e "\e[38;5;82mInstalling git and salt-master\e[38m"
sudo apt-get -y install git salt-master
echo -e "\e[38;5;82mCloning git repo\e[38m"
git clone https://github.com/robado/live-usb-configuration
cd live-usb-configuration

echo -e "\e[38;5;82mInstalling git repo modules\e[38m"
./highstate.sh
echo -e "\e[38;5;82mOpening terminals and gtop in one of them\e[38m"
./terminal.sh %% cd 

echo -e "Exiting......"
exit
