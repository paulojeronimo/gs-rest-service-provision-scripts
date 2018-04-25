if $https_enabled
then
  log Configuring HTTPS on $op ...
  cd ~/$op-certificate
  ./app install-https
else
  log Configuration of HTTPS is disabled by \"http_enabled\" variable
fi
