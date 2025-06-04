# The general rule is:
# .zprofile: Environment variables, PATH modifications, and login shell setup
# .zshrc: Interactive shell configuration, aliases, functions, and prompt customisation


ZSH=$HOME/.oh-my-zsh

# oh-my-zsh default theme
ZSH_THEME="robbyrussell"

# oh-my-zsh plugins
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search direnv)

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"

# Aliases created by common-aliases plugin: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
# we need `lt` for https://github.com/localtunnel/localtunnel. Common-aliases sets: alias lt='ls -ltFh'
unalias lt


# Store your own aliases in the ~/.aliases file and load them here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"


# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1


# Load pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init - 2>/dev/null)"
  RPROMPT+='[🐍 $(pyenv version-name)]'
fi

# Old pyenv setup 
# type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init - 2> /dev/null)" && RPROMPT+='[🐍 $(pyenv version-name)]'


# Updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# Enable shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
