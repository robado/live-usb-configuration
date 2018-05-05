# MySaltModule
Configure your Live-USB FAST
___

I started building my Salt Module with making state for installing programs that I want to. 
For testing I connected to my master which is on my server to know that my code will work.

So I firs started by installing apps that I wanted. 
I created needed folders for this to work **srv/salt/** and necessary files and folders inside. 
I wanted to install **vim** texteditor, **shutter** for taking screenshots and taking screen 
pictures of certain areas and **atom** for coding.

I started by making a file on what programs I wanted module to install:

	$ cat init.sls 
	apps:
  	  pkg.installed:
	    - pkgs:
	      - vim
	      - shutter
	      - retext
	      - git



Then I had to modifie my **top.sls** file for when I run the file it will install them.

    $ cat top.sls 
    base:
      '*':
        - helloworld
        - apps


And now when I run run it with:

	sudo salt 'ubuntu' state.highstate
	ubuntu:
	----------
          ID: /tmp/helloworld.txt
    Function: file.managed
      Result: True
     Comment: File /tmp/helloworld.txt is in the correct state
     Started: 17:38:53.095868
    Duration: 802.005 ms
     Changes:   
	----------
          ID: apps
    Function: pkg.installed
      Result: True
     Comment: 4 targeted packages were installed/updated.
     Started: 17:38:55.795794
    Duration: 7849.789 ms
     Changes:   
              ----------
              git:
                  ----------
                  new:
                      1:2.17.0-1ubuntu1
                  old:
              git-completion:
                  ----------
                  new:
                      1
                  old:
              git-core:
                  ----------
                  new:
                      1
                  old:
              retext:
                  ----------
                  new:
                      7.0.1-1
                  old:
              shutter:
                  ----------
                  new:
                      0.94-1
                  old:
              vim:
                  ----------
                  new:
                      2:8.0.1453-1ubuntu1
                  old:

	Summary for ubuntu
	------------
	Succeeded: 2 (changed=1)
	Failed:    0
	------------
	Total states run:     2

The helloworld was just for testing and I forgot to remove it, but then again it never hurts to 
know that everything works!

So now I have made it to download the files I wanted. But this isn't all what I wanted my module
to do. When running this module I want it to update and upgrade and clone my repository from
github and that is done with **bash** scripts.

I started creating a file where I'm going to gather all the script commands.
I started doing everything step-by-step. So firstly I added **update** and
**upgrade** commands:
	$ cat start.sh 
#!/bin/bash
sudo apt-get update && sudo apt-get upgrade

And because on live-ubuntu (don't know how on other distros) you have to active 
**Community-maintained free and open-source software (univer)** to download 
any app so I added that before the updates:

	#!/bin/bash
	sudo add-apt-repository universe
	sudo apt-get update && sudo apt-get upgrade


I wanted to somehow automatically open 2 terminals and I had no idea on how to
do it. I didn't know how it was suppose to be done or how so I started to 
test stuff but I was thinking it can be done with **shell scripting**. [Help I found on 
StackExchange forums](https://superuser.com/questions/226167/open-terminal-on-start-in-a-specific-place-and-size)


After a while I found that 

	#!/bin/bash
	gnome-terminal 

Will open a new terminal!
So now I just had to make it as what I want it to look like.
After a while I found how to modify the size of a new terminal:

	#!/bin/bash
	gnome-terminal --geometry=150x50


Now I had to do so that they will place correctly! 
After a while I found out how I could start terminals in a specific way. So I added the four terminal
window I wanted. There is probably better ways on doing this but this is the way I found on how to do.

	#!/bin/bash
	gnome-terminal --geometry=101x26+0
	gnome-terminal --geometry=101x26+0-0
	gnome-terminal --geometry=101X26+1500
	gnome-terminal --geometry=101X26+1500-0

This is my script to open 4 terminals as I want them to open.

First when I tried this bash on a fresh live-usb (which had Ubuntu 18.04 LTS) it didn't work and I knew why it didn't because I errors said it clearly. So I fixed it and I also borrowed a few commands from [my teachers github repository](https://github.com/terokarvinen/sirotin).

After fixes my bash script worked! It enables universe so any program can be downloaded, it updates and upgrades, it installs git and salt-master, clones the github repo, opens four terminals, runs the salt command to install the programs and exit that terminal which was opened to run this script.

This is how the code looks finallized:

    #!/bin/bash
    sudo add-apt-repository universe
    sudo apt-get update && sudo apt-get upgrade

    sudo apt-get -y install git salt-master
    git clone https://github.com/robado/live-usb-configuration
    cd live-usb-configuration

    ./terminal.sh %% cd 
    ./highstaterun.sh

    exit


I also had to remove git from salt to install it because my script is already installing to clone the repository. 


	apps:
	  pkg.installed:
	  - pkgs:
	    - vim
	    - shutter
	    - retext


So I also wanted to install **gtop** program for monitoring system. I had so many problems that I even forgot to report what I was doing but basically my most main problem was to write the right **ini.sls** that would install **npm**, ** nodejs** and then **gtop**. 

Firstly I needed to find out how to install npm programs. [Information for npm programs installation I got from Saltstack doumentation](https://docs.saltstack.com/en/latest/ref/states/all/salt.states.npm.html). Then I had to figure out how to install gtop after npm and nodejs was installed. This I found out with **A LOT OF TRIAL AND ERRORS**. But finally after many tries I figured it out. So I figured out and then also because ubuntu 18.04 and ubuntu 16.04 require different names for nodejs so I had to make and **if-statement**. 

So after all tries, this is what my code looks for installing gtop:

    npm:
      pkg.installed

    nodejs:
      pkg.installed:
       {% if grains['osrelease'] == '18.04' %}
       - name: nodejs
       {% elif grains['osrelease'] == '16.04' %}
       - name: nodejs-legacy
       {% endif %}

    gtop:
      npm.installed:
        - require:
          - pkg: npm


This installs gtop. Had to update my **top.sls** file too to include gtop:

    base:
      '*':
       - apps
       - helloworld
       - gtop


So now with all the other programs, my salt module installs gtop.

Then I also modified the **terminal.sh** script to open gtop in one of the terminal.

    #!/bin/bash
    gnome-terminal --geometry=101x26+0
    gnome-terminal --geometry=101x26+0-0
    gnome-terminal --geometry=101X26+1500
    gnome-terminal --geometry=101X26+1500-0 -e gtop

I just added **-e gtop** and that opens the gtop program. 

Now I had to collect everything so you don't have to do but enter 3 commands and all will be installed.

This is what my **start.sh** looks like now when it works!

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
	./highstaterun.sh
	echo -e "\e[38;5mOpening terminals and gtop in one of them\e[38;5m"
	./terminal.sh

	echo -e "Exiting......"
	exit
	
Other files what you want to look closer, they can be found right here in my repository!

When I finished my module, I also had to test it! So I booted a fresh new live-ubuntu 18.04 and ran the command:

	wget https://raw.github.com/robado/live-usb-configuration/master/start.sh
	bash start.sh
	 

And finally:

## Usage
You need to only use two commands:

     wget https://raw.github.com/robado/live-usb-configuration/master/start.sh
     bash start.sh
      
     
There is one space after **bash start.sh** so it will run it.

