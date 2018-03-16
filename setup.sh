#!/bin/bash

__DIR="$(cd "$(dirname "${BASH_SOURCES[0]}")" ; pwd -P)"

setup_git_config() {
  git config --global user.name "Joe Nudell"
  git config --global user.email "jnu@stanford.edu"
}

setup_git_aliases() {
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.st status
  git config --global alias.ci commit
}

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

echo "Setting git config ..."
setup_git_config
echo "Setting up git aliases ..."
setup_git_aliases
echo "Setting up bash_profile ..."
setup_bash_prof
echo "Setting up vimrc ..."
setup_vim_rc

echo "Done!"
