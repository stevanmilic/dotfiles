#setup antigen, plugin manager for zsh
source ~/Applications/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle gradle
antigen bundle common-aliases
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

#ls solarized
#antigen bundle joel-porquet/zsh-dircolors-solarized
eval `dircolors ~/.dir_colors/dircolors`

#my theme ftw
antigen theme agnoster

#git root command
antigen bundle mollifier/cd-gitroot

#cool autosuggestion
#antigen bundle zsh-users/zsh-autosuggestions

# Tell antigen that you're done.
antigen apply

# used by agnoster theme
export DEFAULT_USER="stevan"

# Neovim default editor
export EDITOR=nvim

if ! { [ -n "$TMUX" ]; } then
    TERM=screen-256color tmux
fi

alias python=python3

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/stevan/.sdkman"
[[ -s "/home/stevan/.sdkman/bin/sdkman-init.sh" ]] && source "/home/stevan/.sdkman/bin/sdkman-init.sh"
