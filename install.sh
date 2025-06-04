#!/bin/zsh

# Get the absolute path of the dotfiles directory (where this script is located)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "-----> Installing dotfiles from: $DOTFILES_DIR"

# Define a function which rename a `target` file to `target.backup` if the file
# exists and if it's a 'real' file, ie not a symlink
backup() {
  target=$1
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      mv "$target" "$target.backup"
      echo "-----> Moved your old $target config file to $target.backup"
    fi
  fi
}

symlink() {
  file=$1
  link=$2
  if [ ! -e "$link" ]; then
    echo "-----> Symlinking your new $link"
    ln -s "$file" "$link"
  fi
}

# For all files `$name` in the present folder except `*.sh`, `README.md`, `settings.json`,
# and `config`, backup the target file located at `~/.$name` and symlink `$name` to `~/.$name`
for name in aliases gitconfig irbrc pryrc rspec zprofile zshrc; do
  if [ ! -d "$name" ]; then
    target="$HOME/.$name"
    backup $target
    symlink "$DOTFILES_DIR/$name" $target
  fi
done

# Install zsh-syntax-highlighting plugin
CURRENT_DIR=`pwd`
ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_PLUGINS_DIR" && cd "$ZSH_PLUGINS_DIR"
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
  echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
  git clone https://github.com/zsh-users/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting
fi
cd "$CURRENT_DIR"

# Symlink VS Code/Cursor settings and keybindings to the present `settings.json` and `keybindings.json` files
# If it's a macOS
if [[ `uname` =~ "Darwin" ]]; then
  # VS Code path
  VSCODE_PATH=~/Library/Application\ Support/Code/User
  # Cursor path
  CURSOR_PATH=~/Library/Application\ Support/Cursor/User
# Else, it's a Linux
else
  VSCODE_PATH=~/.config/Code/User
  CURSOR_PATH=~/.config/Cursor/User
  # If this folder doesn't exist, it's a WSL
  if [ ! -e $VSCODE_PATH ]; then
    VSCODE_PATH=~/.vscode-server/data/Machine
  fi
fi

# Symlink for both VS Code and Cursor
for editor_path in "$VSCODE_PATH" "$CURSOR_PATH"; do
  if [ -d "$(dirname "$editor_path")" ]; then
    mkdir -p "$editor_path"
    for name in settings.json keybindings.json; do
      target="$editor_path/$name"
      backup $target
      symlink "$DOTFILES_DIR/$name" $target
    done
  fi
done

# Symlink Cursor-specific configurations
if [[ `uname` =~ "Darwin" ]]; then
  CURSOR_CONFIG_DIR=~/.cursor
  mkdir -p "$CURSOR_CONFIG_DIR"
  
  # Symlink MCP configuration if it exists
  if [ -f "$DOTFILES_DIR/cursor_mcp.json" ]; then
    target="$CURSOR_CONFIG_DIR/mcp.json"
    backup $target
    symlink "$DOTFILES_DIR/cursor_mcp.json" $target
  fi
fi

# Symlink SSH config file to the present `config` file for macOS and add SSH passphrase to the keychain
if [[ `uname` =~ "Darwin" ]]; then
  target=~/.ssh/config
  backup $target
  symlink "$DOTFILES_DIR/config" $target
  
  # Add SSH key to keychain if it exists
  if [ -f ~/.ssh/id_ed25519 ]; then
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
  fi
fi

# Refresh the current terminal with the newly installed configuration
exec zsh

echo "👌 Carry on with git setup!"
