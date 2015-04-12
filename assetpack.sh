#!/bin/sh
# if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
#   source "$HOME/.rvm/scripts/rvm"
# elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
#   source "/usr/local/rvm/scripts/rvm"
# else
#   printf "ERROR: An RVM installation was not found.\n"
# fi

source /usr/local/rvm/environments/ruby-2.1.2
rake assetpack:build
