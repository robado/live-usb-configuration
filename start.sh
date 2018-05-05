#!/bin/bash
sudo add-apt-repository universe
sudo apt-get update && sudo apt-get upgrade

sudo apt-get -y install git salt-master
git clone https://github.com/robado/live-usb-configuration
cd live-usb-configuration

./terminal.sh %% cd 
./highstaterun.sh

exit
