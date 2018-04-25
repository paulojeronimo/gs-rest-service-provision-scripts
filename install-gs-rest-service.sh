cd
repo=https://github.com/spring-guides/$op.git
log "Installing $op ($repo) into $PWD ..."
git clone $repo &>> $LOG
