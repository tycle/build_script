#!/bin/bash
# Specify colors utilized in the terminal
normal='tput sgr0'              # White
red='tput setaf 1'              # Red
green='tput setaf 2'            # Green
yellow='tput setaf 3'           # Yellow
blue='tput setaf 4'             # Blue
violet='tput setaf 5'           # Violet
cyan='tput setaf 6'             # Cyan
white='tput setaf 7'            # White
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) # Bold Red
bldgrn=${txtbld}$(tput setaf 2) # Bold Green
bldblu=${txtbld}$(tput setaf 4) # Bold Blue
bldylw=$(txtbld)$(tput setaf 3) # Bold Yellow
bldvlt=${txtbld}$(tput setaf 5) # Bold Violet
bldcya=${txtbld}$(tput setaf 6) # Bold Cyan
bldwht=${txtbld}$(tput setaf 7) # Bold White

clear
tput setaf 3
	echo -e "${bldcya}Enter the path where source code should be downloaded in full format.\nDefault is ${HOME}/cm-14.1"
tput setaf 4
        echo 
	# cd .repo/manifests 
        # git reset --hard
        # git clean -fd
        # cd ../..
        cd .repo/repo
        echo  
        git reset --hard
        git clean -fd
        cd ../..
        echo  
        repo forall -c "git reset --hard" -j4
        repo forall -c "git clean -fd" -j4
	time repo sync -f --force-sync --no-clone-bundle
	echo  
	echo  
	echo -e "${bldcya}Repo have been reset and clean"
	echo -e "${bldcya}The Cyannogen Source Code has been downloaded"
	echo -e "${bldcya}You can now run the build script"
	echo -e "${bldcya}Please remember to run ccache -M 40 to set 40gb of ccache, before you start your first build :D" 
	echo -e "${bldcya}This value can be shifted up/down a bit to your liking" 
exit
