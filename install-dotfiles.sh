cd
log "Installing dotfiles ($dotfiles_repo) into $PWD ..."
git clone $dotfiles_repo &>> $LOG
./dotfiles/install &>> $LOG
