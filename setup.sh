__DIR=

[ ${BASH_VERSION} ] && __DIR="$(cd "$(dirname "${BASH_SOURCES[0]}")" ; pwd -P)"
[ ${ZSH_VERSION} ] && __DIR=$(pwd)

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

setup_flake8() {
    python3 -m pip install --user flake8
}

setup_zsh_prof() {
    ZSH_RC=~/.zshrc

    if [ -f $ZSH_RC ]; then
        echo "ZSH settings exist. Overwrite?"
        select yn in "Yes" "No"; do
          case $yn in 
            Yes ) rm $ZSH_RC; break;;
            No ) return;;
          esac
        done
    fi

    ln -s "$__DIR/lib/.zshrc" $ZSH_RC
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

init_submodules() {
  git submodule init
  find linked/ -maxdepth 1 -mindepth 1 -type d -exec git submodule update {} \;
}

link_pathogen_plugin() {
  SRC="$__DIR/linked/$1"
  DEST="$HOME/.vim/bundle/$1"
  echo "Linking $SRC to $DEST ..."
  if [ ! -L "$DEST" ]; then
    ln -s "$SRC" "$DEST"
  else
    echo " ... already exists"
  fi
}

setup_vim_pathogen_plugins() {
  link_pathogen_plugin "typescript-vim"
  link_pathogen_plugin "tsuquyomi"
  link_pathogen_plugin "csv.vim"
  link_pathogen_plugin "vim-es6"
  link_pathogen_plugin "vim-flake8"
  link_pathogen_plugin "vim-go"
  link_pathogen_plugin "syntastic"
  link_pathogen_plugin "vim-antlr"
  link_pathogen_plugin "vim-less"
  link_pathogen_plugin "vim-graphql"
}

setup_ptp_config() {
  mkdir -p ~/.ptpython
  if [ -f ~/.ptpython/config.py ]; then
    echo "Ptpython config exists. Overwrite?"
    select yn in "Yes" "No"; do
      case $yn in
        Yes ) rm ~/.ptpython/config.py; break;;
        No ) return ;;
      esac
    done
  fi
  ln -s "$__DIR/lib/ptpython.config.py" ~/.ptpython/config.py
}

setup_tmux_config() {
  TMUX_CONF=~/.tmux.conf
  
  if [ -f $TMUX_CONF ] || [ -L $TMUX_CONF ]; then
    echo "tmux conf exists. Overwrite?"
    select yn in "Yes" "No"; do
      case $yn in
        Yes ) rm $TMUXRC; break;;
        No ) return;;
      esac
    done
  fi

  ln -s "$__DIR/lib/.tmux.conf" $TMUX_CONF
}

setup_omz() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  setup_zsh_prof
}

setup_vim_go() {
  vim +GoInstallBinaries +qall
}
  
  

echo "Setting git config ..."
setup_git_config
echo "Setting up git aliases ..."
setup_git_aliases
if [ -n "${BASH_VERSION}" ]; then
  echo "Setting up bash_profile ..."
  setup_bash_prof
elif [ -n "${ZSH_VERSION}" ]; then
  echo "Setting up zsh config ..."
  setup_omz
fi
echo "Setting up vimrc ..."
setup_vim_rc
echo "Setting up tmux ..."
setup_tmux_config
echo "Adding plugins ..."
init_submodules
setup_vim_pathogen_plugins
echo "Installing plugin bundles ..."
setup_vim_go
echo "Setting up ptpython config ..."
setup_ptp_config
echo "Setting up flake8"
setup_flake8

echo "Done!"
