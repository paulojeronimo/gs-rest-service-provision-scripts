cd
name=$op-certificate
repo=https://github.com/paulojeronimo/$name.git
log "Installing $name ($repo) into $PWD ..."
git clone $repo &>> $LOG
