# Export var to check if it is apple silicon
export IS_APPLE_SILICON=$([[ "$(sysctl -n machdep.cpu.brand_string)" == *"Apple"* ]] && echo 1)

# Has to be here before paths to enable brew resolution
if [[ "$IS_APPLE_SILICON" -eq 1 ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

DOTFILES_PATH=~/.dotfiles
PATHS=/.paths
ENV=/.env
ALIASES=/.aliases
FUNCTIONS=/.functions
WORK_DIR=/.work

# Path
[[ -f "$DOTFILES_PATH$PATHS" ]] && source "$DOTFILES_PATH$PATHS"

# Env
[[ -f "$DOTFILES_PATH$ENV" ]] && source "$DOTFILES_PATH$ENV"

# Aliases
[[ -f "$DOTFILES_PATH$ALIASES" ]] && source "$DOTFILES_PATH$ALIASES"

# Load fuzzy finder for stuff
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### Cargo Rust package manager env ###
source "$HOME/.cargo/env"

# Load .nvm
[[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ]] && source "$(brew --prefix)/opt/nvm/nvm.sh"  # This loads nvm
[[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ]] && source "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"


# The next line enables shell command completion for gcloud.
[[ -f "$HOME/.bin/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/.bin/google-cloud-sdk/completion.zsh.inc"

# Init starship prompt configuration
eval "$(starship init zsh)"

# enable zsh-autosuggestion
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

sh "$DOTFILES_PATH"/bootstrap/colorlogin.sh

# Functions
[[ -f "$DOTFILES_PATH$FUNCTIONS" ]] && source "$DOTFILES_PATH$FUNCTIONS"

# Load utils from .work directory
[[ -d "$DOTFILES_PATH$WORK_DIR" ]] && [[ -f "$DOTFILES_PATH$WORK_DIR"/.zsh_ext ]] && source "$DOTFILES_PATH$WORK_DIR"/.zsh_ext

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
