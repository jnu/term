# Get the true path of the bash profile (in this repo) from the symlink.
# Use this as the base path for additional includes.
DIR="$( cd "$( dirname "$( readlink "${BASH_SOURCE[0]}" )" )" ; pwd -P )"

source "$DIR/.git-completion"
source "$DIR/.git-prompt"

export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="\[\u@\h\] \w\$(__git_ps1)> "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
