/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew upgrade

brew install --cask ghostty
brew install --cask phpstorm
brew install --cask postman

# Install nerd-font via homebrew for macOs.
brew install font-hack-nerd-font

# Then install prompt framework
brew install starship

# install autosuggestion for zsh
brew install zsh-autosuggestions

# git large files manager
brew install git-lfs

# install node latest and node
brew install node
brew install node@22

brew install nvm
mkdir ~/.nvm
source $(brew --prefix nvm)/nvm.sh

# install php versions
brew install php
brew install php@8.2
brew install php@8.3
brew install php@8.4
swphp 8.5

# install xdebug
brew install pie
pie install xdebug/xdebug

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
brew install --cask bitwarden
brew install --cask appcleaner
brew install --cask malwarebytes
#install bitdefender virus scanner from apple store

## some utils to have
brew install ripgrep
brew install fd
brew install jq
#brew install jesseduffield/lazygit/lazygit
#brew install neovim

# Enable fuzzy finder
brew install fzf
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install

# This mirror the .config in ~
# See https://savannah.gnu.org/git/?group=stow
brew install stow

# use z as cd
# see https://github.com/ajeetdsouza/zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
