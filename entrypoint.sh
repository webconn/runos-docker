#!/bin/bash

# create user to fix owner of local files
export DEV_UID="${DEV_UID:-1000}"
DEV_USER="${DEV_USER:-user}"
DEV_GID="${DEV_GID:-$DEV_UID}"
DEV_GROUP="${DEV_GROUP:-$DEV_USER}"

# check if user/group exist
if ! getent group $DEV_GROUP >& /dev/null; then
        addgroup --gid "$DEV_GID" "$DEV_GROUP" >& /dev/null
fi

if ! getnet passwd  "$DEV_USER" >& /dev/null; then
        adduser --uid $DEV_UID --gecos "" --gid $DEV_GID --disabled-password --home "/userdata" "$DEV_USER" >& /dev/null
fi

# configure sudo for this user
echo "root ALL=(ALL) ALL" > /etc/sudoers
echo "$DEV_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo 'Defaults env_keep += "PATH http_proxy https_proxy LD_LIBRARY_PATH"' >> /etc/sudoers

ip a

# run su with current user
sudo -E -i -u $DEV_USER /bin/bash --rcfile /etc/bashrc.sh
