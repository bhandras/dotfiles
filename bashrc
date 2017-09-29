export GOPATH=$HOME/stuff/go
export PATH=$PATH:$HOME/bin:$GOPATH/bin

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

export HOMEBREW_GITHUB_API_TOKEN=""

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vim='mvim -v'
alias cds='cd $HOME/stuff'
alias cdp='cd $HOME/stuff/personal'
alias cdw='cd $HOME/stuff/work'
alias cdg='cd $GOPATH/src'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
