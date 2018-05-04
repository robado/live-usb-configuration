#!/bin/bash
sudo add-apt-repository universe
sudo apt-get update && sudo apt-get upgrade

sudo apt-get -y install salt-master

./terminal.sh
./highstaterun.sh
