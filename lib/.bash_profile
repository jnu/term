# Get the true path of the bash profile (in this repo) from the symlink.
# Use this as the base path for additional includes.
__BP_INCLUDE_DIR="$( cd "$( dirname "$( readlink "${BASH_SOURCE[0]}" )" )" ; pwd -P )"

source "$__BP_INCLUDE_DIR/.git-completion"
source "$__BP_INCLUDE_DIR/.git-prompt"

export EDITOR="vim"
export VISUAL="vim"

export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export PROMPT_COMMAND='__git_ps1 "\[\033[01;33m\]\u@\h:\[\033[01;34m\]\w\[\033[01;0m\]" "> "'

if [[ "$(uname)" == "Darwin" ]]; then
  alias ls='ls -G'
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
else
  alias ls='ls --color=auto'
  export LSCOLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
fi
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

[ -e ~/.bashrc ] && \. ~/.bashrc # Load bash rc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"

# command -v tmux >/dev/null 2>&1 && start_tmux
