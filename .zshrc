# aliases
alias k=kubectl
alias python=python3.10
alias kctx=kubectx
alias kns=kubens

# setup antigen, plugin manager for zsh
source ~/Applications/antigen/antigen.zsh

antigen init ~/.antigenrc

eval `gdircolors ~/.dir_colors/dircolors`

# used by agnoster theme
export DEFAULT_USER=$USER

# Set the default python virtualenv directory for python projects.
export AUTOSWITCH_FILE=".env"
export AUTOSWITCH_VIRTUAL_ENV_DIR=".env"

# Neovim default editor
export EDITOR=nvim

export PYTHONBREAKPOINT=ipdb.set_trace
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export GOPATH=$HOME/Applications/go
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

PATH=$HOME/.local/bin:$GOPATH/bin/:$PATH

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.poetry/bin:$HOME/.cargo/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='
  --color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
  --color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B
'

if ! { [ -n "$TMUX" ]; } then
  tmux
fi
