
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PATH=${PATH}:$HOME/android-sdk-macosx/platform-tools:$HOME/android-sdk-macosx/tools

export PATH=/usr/local/texlive/2011/bin:$PATH

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

export PATH="/usr/local/heroku/bin:$PATH"

export PROMPT_COMMAND='echo -ne "\033]0;[${PWD/$HOME/~}]\007"'