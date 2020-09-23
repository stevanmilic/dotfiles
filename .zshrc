# zsh version 5.1.1
# setup antigen, plugin manager for zsh
source ~/Applications/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle common-aliases
antigen bundle command-not-found
antigen bundle pip

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# ls solarized
# antigen bundle joel-porquet/zsh-dircolors-solarized
eval `dircolors ~/.dir_colors/dircolors`

# my theme ftw
antigen theme agnoster

# git root command
antigen bundle mollifier/cd-gitroot

# cool autosuggestion
# antigen bundle zsh-users/zsh-autosuggestions

# Tell antigen that you're done.
antigen apply

# used by agnoster theme
export DEFAULT_USER=$USER

# set bat theme
export BAT_THEME="Solarized (dark)"

# Neovim default editor
export EDITOR=nvim

if ! { [ -n "$TMUX" ]; } then
  tmux
fi

export PYTHONBREAKPOINT=ipdb.set_trace

export GOPATH=$HOME/Applications/go
PATH=$HOME/.gem/ruby/2.5.0/bin:$HOME/.local/bin:$GOPATH/bin/:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# aliases
alias fzo='nvim $(fzf)'
alias greylabel='cd ~/tradecore/brokeriq/greylabel/ && source .env/bin/activate && nvim'
alias castle-dir='cd ~/tradecore/castle/ && source .env/bin/activate && nvim'
alias remap='xmodmap ~/.Xmodmap'
alias tcvpn='sudo openvpn ~/tradecore/smilic.ovpn'
alias rurxvt='~/restart_urxvt.sh -checkout'
alias fd=fd
alias git=hub
alias k=kubectl

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.poetry/bin:$PATH"
