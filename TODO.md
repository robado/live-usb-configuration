# Run locally
To run commands locally I used:

    sudo salt-call --local --file-root /home/ubuntu/live-usb-configuration/srv/salt/ --pillar-root srv/pillar/ state.highstate -ldebug

For enabling multiver for downloading programs:

    sudo add-apt-repository universe


