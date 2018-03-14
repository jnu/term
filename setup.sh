#!/bin/bash

DIR="$(cd "$(dirname $0)" ; pwd -P)"
BASH_PROF=~/.bash_profile

if [ -f $BASH_PROF ] || [ -L $BASH_PROF ]; then
  echo "Bash profile exists. Overwrite?"
  select yn in "Yes" "No"; do
    case $yn in 
      Yes ) rm ~/.bash_profile; break;;
      No ) exit;;
    esac
  done
fi

ln -s "$DIR/lib/.bash_profile" $BASH_PROF
source $BASH_PROF
