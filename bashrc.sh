#!/bin/bash

[ -f ~/.bashrc ] && . ~/.bashrc

# go to mounted directory
cd /userdata

if [ -d runos ]; then 
        echo '-> Found runos directory in here, apply debug envs...'
        mkdir -p runos/build && cd runos/build
        source ../debug_run_env.sh
        cd ../../
else
        echo '-> WARNING: No runos directory found here, you need to run "source ../debug_run_env.sh" by yourself'
fi

# use bash-completion
. /etc/bash_completion
