# The general rule is:
# .zprofile: Environment variables, PATH modifications, and login shell setup
# .zshrc: Interactive shell configuration, aliases, functions, and prompt customisation


# OH-MY-ZSH
# Full configs at https://github.com/ohmyzsh/ohmyzsh/wiki/Settings

# oh-my-zsh folder path
ZSH=$HOME/.oh-my-zsh

# oh-my-zsh theme
ZSH_THEME="robbyrussell"

# oh-my-zsh plugins
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search direnv)

# Actually load oh-my-zsh
source "${ZSH}/oh-my-zsh.sh"

# Aliases created by common-aliases plugin: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
# we need `lt` for https://github.com/localtunnel/localtunnel. Common-aliases sets: alias lt='ls -ltFh'
unalias lt


# ALIAS
# Store your own aliases in the ~/.aliases file and load them here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"


# HOMEBREW
# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1


# GOOGLE CLOUD

# Updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# Enable shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
