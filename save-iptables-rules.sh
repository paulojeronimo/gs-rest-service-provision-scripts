log Making iptables configurations persistent ...
sudo sh -c "iptables-save > /etc/iptables.rules" &>> $LOG

# The following command is mandatory but it hangs the provision
# the workaround is to execute this inside the instance after its provision
# TODO: see how to fix this issue
#sudo apt-get -yq install iptables-persistent &>> $LOG
