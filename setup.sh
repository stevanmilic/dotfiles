# dependency install for arch
sudo pacman -S zsh
sudo pacman -S tmux
sudo pacman -S neovim
sudo pacman -S xclip

# dotfiles expansion
cd ~/
git clone git@github.com:stevanmilic/dotfiles.git
mv ~/dotfiles/.tmux.conf ~/
mv ~/dotfiles/.Xresources .
mv ~/dotfiles/.zshrc .
mkdir -p ~/.config/nvim/
mv ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/

# antigen
mkdir -p ~/Applications/antigen/
curl -L git.io/antigen > ~/Applications/antigen/antigen.zsh

# TODO: instal python pip, and create vms for neovim

# dein => neovim
mkdir ~/Applications/dein/
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/Applications/dein/installer.sh
sh ~/Applications/dein/installer.sh ~/.config/nvim/
# call dein#install() from neovim

# zsh shell
chsh -s $(which zsh)
# logout and login required

# tmux plugin manager => tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
# TODO: Press prefix + I (capital I, as in Install) to fetch the plugin.

# git checkout solarized.vim and powerline.theme
