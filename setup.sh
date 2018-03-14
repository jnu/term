#!/bin/bash

__DIR="$(cd "$(dirname "${BASH_SOURCES[0]}")" ; pwd -P)"

setup_bash_prof() {
  BASH_PROF=~/.bash_profile

  if [ -f $BASH_PROF ] || [ -L $BASH_PROF ]; then
    echo "Bash profile exists. Overwrite?"
    select yn in "Yes" "No"; do
      case $yn in 
        Yes ) rm $BASH_PROF; break;;
        No ) return;;
      esac
    done
  fi

  ln -s "$__DIR/lib/.bash_profile" $BASH_PROF
  source $BASH_PROF
}

setup_vim_rc() {
  VIMRC=~/.vimrc
  
  if [ -f $VIMRC ] || [ -L $VIMRC ]; then
    echo "Vimrc exists. Overwrite?"
    select yn in "Yes" "No"; do
      case $yn in
        Yes ) rm $VIMRC; break;;
        No ) return;;
      esac
    done
  fi

  ln -s "$__DIR/lib/.vimrc" $VIMRC
  mkdir -p ~/.vim/colors
  ln -s "$__DIR/lib/badwolf.vim" ~/.vim/colors/badwolf.vim
}

echo "Setting up bash_profile ..."
setup_bash_prof
echo "Setting up vimrc ..."
setup_vim_rc

echo "Done!"
