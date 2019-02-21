
#!/usr/bin/env bash
# Find the source directory of our scripts so we can include our config
# We have to use readlink since we symlink our scripts in the install process
SCRIPTS_PATH="$(dirname "$(readlink -f "$0")")"

# Source in Configuration
. $SCRIPTS_PATH/config.sh

SSH_COMMAND="ssh $E310_USER@$E310_IP"

copy_public_key(){
    AUTHORIZED_KEY_FILE=~/.ssh/authorized_keys
    touch $AUTHORIZED_KEY_FILE
    $SSH_COMMAND "cat /home/root/.ssh/id_rsa.pub" >> $AUTHORIZED_KEY_FILE
}

umount_host_folder(){
    $SSH_COMMAND "umount $E310_FOLDER"
}

mount_host_folder(){
    # logs in, creates destination folder if it doesn't exist
    # mounts the host folder inside
    umount_host_folder
    $SSH_COMMAND "mkdir -p $E310_FOLDER; sshfs -o reconnect $HOST_USER@$HOST_IP:$HOST_FOLDER $E310_FOLDER"
}

CMD=$1
case $CMD in
    mount)
        echo "Mounting $HOST_FOLDER within $E310_FOLDER on E310"
        mount_host_folder
    ;;
    unmount)
        echo "Unmounting $E310_FOLDER on E310"
        umount_host_folder
    ;;
    grc)
        echo "Running gnu-radio companion"
        $SSH_COMMAND -X "gnuradio-companion"
    ;;
    ssh)
        clear
        $SSH_COMMAND
    ;;
    copyKey)
        copy_public_key
    ;;
    *)
        echo "
        Available Commands
        ------------------
        mount   - mount this directory into E310
        unmount - unmount host directory on E310
        grc     - Runs gnu radio Companion interactively
        ssh     - open up interactive shell
        copyKey - copies public key from E310
        "
        ;;
esac
