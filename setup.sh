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
	sleep 1
	echo  
	echo Updating Package Lists...
	echo  
	sleep 3
tput setaf 2
	time sudo apt-get update
tput setaf 3
	echo  
	echo Installing necessary dependencies...
	echo  
	sleep 3
tput setaf 2
	time sudo apt-get install git automake lzop flex bison gperf build-essential \
	zlib1g-dev zlib1g-dev:i386 g++-multilib python-networkx libxml2-utils bzip2 libbz2-dev libbz2-1.0 \
	libghc-bzlib-dev pngcrush schedtool liblz4-tool optipng maven yasm libc6-dev:i386 \
	linux-libc-dev:i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev \
	libxml2-utils xsltproc yasm
tput setaf 3
	echo  
	echo Settings up USB Ports...
	echo  
	sleep 3
tput setaf 2
	sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/snowdream/51-android/master/51-android.rules
	sudo chmod 644   /etc/udev/rules.d/51-android.rules
	sudo chown root /etc/udev/rules.d/51-android.rules
	sudo service udev restart
	adb kill-server
	sudo killall adb
tput setaf 3
	echo  
	echo Setting up ccache
	echo 
tput setaf 2 	
	git clone https://git.samba.org/ccache.git
	cd ccache
	./autogen.sh
	./configure
	make
	sudo cp -v ./ccache /usr/bin/ccache
	echo "export USE_CCACHE=1" >> ${HOME}/.bash.cm
	echo  
tput setaf 3
	echo Downloading repo tool, if already present will update to the latest version...
tput setaf 2
	cd ..
	echo  
	sleep 2
	mkdir -p ~/bin
	PATH=~/bin:$PATH
	curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
	chmod a+x ~/bin/repo
clear

tput setaf 3
	echo -e "${bldcya}Enter the path where source code should be downloaded in full format.\nDefault is ${HOME}/cm-14.1"
tput setaf 2
	repo init -u git://github.com/tycle/android.git -b cm-14.1
	time repo sync -f --force-sync --no-clone-bundle
	echo  
	echo -e "${bldcya}The RR Source Code has been downloaded into ${rrpath}"
	echo -e "${bldcya}You can now run the build script in ${rrpath}"
	echo -e "${bldcya}Please remember to run ccache -M 40 to set 40gb of ccache, before you start your first build :D" 
	echo -e "${bldcya}This value can be shifted up/down a bit to your liking" 
tput setaf 2
clear
	echo -e "${bldcya}      Set up is now completed! "
exit
