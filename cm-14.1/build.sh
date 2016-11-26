#!/bin/bash

# Make sure you're in rr source dir
[ -d ".repo" ] || exit 1
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

export USE_CCACHE=1
export JACK_SERVER_VM_ARGUMENTS="-Xmx3072M -Dfile.encoding=UTF-8 -XX:+TieredCompilation"

CCACHE_BIN=$(which ccache)
if [ -z "$CCACHE_BIN" ]
then
  CCACHE_BIN="prebuilts/misc/linux-x86/ccache/ccache"
fi
if [ -z "$CCACHE_DIR" ]
then
  export CCACHE_DIR=.ccache
  if [ ! -d "$CCACHE_DIR" -a -x "$CCACHE_BIN" ]
  then
    mkdir -p "$CCACHE_DIR"
    $CCACHE_BIN -M 40G
  fi
fi
tput setaf 3
    sleep 1
    echo
    echo Setting up Build Environment...
    echo
	sleep 2
tput setaf 1
	source build/envsetup.sh
tput setaf 1
	echo -e "You have chosen to build ResurrectionRemix OS for ${bldred} ${device}"
	echo  
	echo -e "${bldvlt}Building Resurrection Remix OS now!"
	echo  
	sleep 3
tput setaf 4
	logfile="Z00A-$(date +%Y%m%d).log"
	lunch cm_Z00A-userdebug && time mka bacon 2>&1 | tee $logfile
	if [ $? -eq 0 ]; then
	printf "Build Suceeded, grab your zip at $(ls ${OUT}/C*.zip)\nBuild log is at ${logfile} incase you need it\n";
	else
	printf "Build failed, check the log at ${logfile}\n";
	exit 1;
	fi
