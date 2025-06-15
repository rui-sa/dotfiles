# The general rule is:
# .zprofile: Environment variables, PATH modifications, and login shell setup
# .zshrc: Interactive shell configuration, aliases, functions, and prompt customisation


export PATH="/usr/local/sbin:$HOME/.local/bin:$PATH"


# Use GNU grep instead of MacOS's BSD grep (and the same for find and xargs)
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"


# Set ipdb as the default Python debugger
export PYTHONBREAKPOINT=ipdb.set_trace


# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# Homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv 2> /dev/null)"
