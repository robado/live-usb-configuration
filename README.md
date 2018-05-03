# MySaltModule
Configure your Live-USB FAST
___

I started building my Salt Module with making state for installing programs that I want to. 
For testing I connected to my master which is on my server to know that my code will work.

So I firs started by installing apps that I wanted. 
I created needed folders for this to work **srv/salt/** and necessary files and folders inside. 
I wanted to install **vim** texteditor, **shutter** for taking screenshots and taking screen 
pictures of certain areas and **atom** for coding.

	$ cat init.sls 
	apps:
  	  pkg.installed:
    	    - pkgs:
	      - vim
      	      - shutter
      	      - retext
      	      - git



