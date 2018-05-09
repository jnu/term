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
  BASH_PROF_EXT=~/.term.bash_profile
  BASH_PROF=~/.bash_profile

  if [ ! -f $BASH_PROF ] && [ ! -L $BASH_PROF ]; then
    echo "Bash profile does not exist. Creating ..."
    touch $BASH_PROF
  fi

  if [ -f $BASH_PROF_EXT ] || [ -L $BASH_PROF_EXT ]; then
    echo "Bash settings exists. Overwrite?"
    select yn in "Yes" "No"; do
      case $yn in 
        Yes ) rm $BASH_PROF_EXT; break;;
        No ) return;;
      esac
    done
  fi

  ln -s "$__DIR/lib/.bash_profile" $BASH_PROF_EXT

  BP_INC=$(grep -c "$BASH_PROF_EXT" $BASH_PROF)
  if [ $BP_INC -lt 1 ]; then
    echo "Bash config not auto-loaded yet. Fixing ..."
    echo "# Custom bash settings from github.com/jnu/term" >> $BASH_PROF
    echo "source $BASH_PROF_EXT" >> $BASH_PROF
  else
    echo "Bash settings already sourced."
  fi

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
  mkdir -p ~/.vim/autoload
  mkdir -p ~/.vim/bundle
  ln -s "$__DIR/linked/vim-pathogen/autoload/pathogen.vim" ~/.vim/autoload/pathogen.vim
}

setup_vim_pathogen_plugins() {
  ln -s "$__DIR/linked/typescript-vim" ~/.vim/bundle/typescript-vim
  ln -s "$__DIR/linked/tsuquyomi" ~/.vim/bundle/tsuquyomi
}

echo "Setting git config ..."
setup_git_config
echo "Setting up git aliases ..."
setup_git_aliases
echo "Setting up bash_profile ..."
setup_bash_prof
echo "Setting up vimrc ..."
setup_vim_rc
echo "Adding plugins ..."
setup_vim_pathogen_plugins

echo "Done!"
