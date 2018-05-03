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


