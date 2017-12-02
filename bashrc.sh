#!/bin/bash

. ~/.bashrc

# PATH for ovs
export PATH=/usr/local/share/openvswitch/scripts:$PATH

cd /root/runos/build
source ../debug_run_env.sh
cd ..
ip a

# use bash-completion
. /etc/bash_completion
