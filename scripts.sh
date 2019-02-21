#!/usr/bin/env bash
SCRIPT_DIR=`dirname $0`
# SCRIPT_PATH=`realpath $SCRIPT_DIR`
# echo "export PATH=$SCRIPT_PATH:"'$PATH' >> ~/.bash_profile

# echo "#Source bash_profile
# . ~/.bash_profile" >> ~/.bashrc

USER_BIN=~/bin

install_config(){
    echo "
#====== CONFIGURATION ========

HOST_IP=192.168.10.1
HOST_USER=`whoami`
HOST_FOLDER="~/Documents"

E310_IP=192.168.10.4
E310_USER=root
E310_FOLDER="/home/\$E310_USER/mounted_host/"

#=============================" >> ./config.sh
}

install(){
    install_config
    mkdir -p $USER_BIN
    ln -sf `realpath ./EThreeTen.sh` $USER_BIN/EThreeTen
}

uninstall(){
    rm $USER_BIN/EThreeTen
}

CMD=$1
case $CMD in
    install)
        install
    ;;
    uninstall)
        uninstall
    ;;
    *)
        echo "
        Available Commands
        ------------------
        install   - links scripts into path
        uninstall - unlinks scripts from path
        "
        ;;
esac