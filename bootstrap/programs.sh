/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew upgrade

brew install --cask kitty
brew install --cask phpstorm
brew install --cask postman

# Install nerd-font via homebrew for macOs.
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# Then install prompt framework
brew install starship

# install autosuggestion for zsh
brew install zsh-autosuggestions

# git large files manager
brew install git-lfs

# install node latest and node 16
brew install node
brew install node@18

brew install nvm
mkdir ~/.nvm
source $(brew --prefix nvm)/nvm.sh

# install php versions
brew install php
brew install php@8.0
brew install php@8.1
brew install php@8.2
brew install php@8.3
swphp 8.2

# install xdebug
mkdir -p $(exec pecl config-get ext_dir)
pecl install xdebug

# install composer
brew install composer

# install docker cli and docker desktop
brew install docker
brew install --cask docker
brew install colima
brew install docker-compose
brew install docker-buildx
mkdir -p ~/.docker/cli-plugins

brew install tmux
curl https://sh.rustup.rs -sSf | sh
cargo install tmux-sessionizer

brew install --cask karabiner-elements
brew install --cask nordpass
brew install --cask rectangle
brew install --cask appcleaner
brew install --cask malwarebytes
#install bitdefender virus scanner from apple store

## some utils to have
brew install ripgrep
brew install fd
brew install jesseduffield/lazygit/lazygit

# Enable fuzzy finder
brew install fzf
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install

brew install stow
