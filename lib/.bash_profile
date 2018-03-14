# Get the true path of the bash profile (in this repo) from the symlink.
# Use this as the base path for additional includes.
__BP_INCLUDE_DIR="$( cd "$( dirname "$( readlink "${BASH_SOURCE[0]}" )" )" ; pwd -P )"

source "$__BP_INCLUDE_DIR/.git-completion"
source "$__BP_INCLUDE_DIR/.git-prompt"

export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export PROMPT_COMMAND='__git_ps1 "\[\033[01;33m\]\u@\h:\[\033[01;34m\]\w\[\033[01;0m\]" "> "'

alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
