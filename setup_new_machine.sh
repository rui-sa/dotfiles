#!/bin/zsh

echo "🚀 Setting up your new machine..."

# Get the absolute path of the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "-----> Dotfiles directory: $DOTFILES_DIR"

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "-----> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "-----> Homebrew already installed"
fi

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "-----> Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "-----> Oh My Zsh already installed"
fi

# Install Homebrew packages
if [ -f "$DOTFILES_DIR/brew_packages.txt" ]; then
    echo "-----> Installing Homebrew packages..."
    while read package; do
        if ! brew list --formula | grep -q "^${package}$"; then
            echo "Installing $package..."
            brew install "$package"
        fi
    done < "$DOTFILES_DIR/brew_packages.txt"
fi

# Install Homebrew casks
if [ -f "$DOTFILES_DIR/brew_casks.txt" ]; then
    echo "-----> Installing Homebrew casks..."
    while read cask; do
        if ! brew list --cask | grep -q "^${cask}$"; then
            echo "Installing $cask..."
            brew install --cask "$cask"
        fi
    done < "$DOTFILES_DIR/brew_casks.txt"
fi

# Install pyenv Python versions
if [ -f "$DOTFILES_DIR/pyenv_versions.txt" ] && command -v pyenv &> /dev/null; then
    echo "-----> Installing Python versions..."
    while read version; do
        if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            continue  # Skip non-version entries (like environment names)
        fi
        if ! pyenv versions --bare | grep -q "^${version}$"; then
            echo "Installing Python $version..."
            pyenv install "$version"
        fi
    done < "$DOTFILES_DIR/pyenv_versions.txt"
fi

# Install Cursor extensions
if [ -f "$DOTFILES_DIR/cursor_extensions.txt" ] && command -v cursor &> /dev/null; then
    echo "-----> Installing Cursor extensions..."
    while read extension; do
        if [[ ! "$extension" =~ ^# ]]; then  # Skip comment lines
            echo "Installing extension: $extension"
            cursor --install-extension "$extension"
        fi
    done < "$DOTFILES_DIR/cursor_extensions.txt"
fi

# Run the main install script to create symlinks
echo "-----> Creating symlinks..."
chmod +x "$DOTFILES_DIR/install.sh"
"$DOTFILES_DIR/install.sh"

# Generate SSH key if it doesn't exist
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "-----> Generating SSH key..."
    read "email?Enter your email for SSH key: "
    ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519 -N ""
    
    if [[ `uname` =~ "Darwin" ]]; then
        ssh-add --apple-use-keychain ~/.ssh/id_ed25519
    fi
    
    echo "-----> Your public SSH key:"
    cat ~/.ssh/id_ed25519.pub
    echo "-----> Add this key to your GitHub/GitLab account"
fi

echo "✅ Setup complete!"
echo ""
echo "📋 Manual steps remaining:"
echo "1. Add your SSH key to GitHub/GitLab"
echo "2. Configure any app-specific settings"
echo "3. Sign into your accounts (Google Drive, etc.)"
echo "4. Install any Mac App Store apps manually"
echo ""
echo "🔄 Restart your terminal or run 'source ~/.zshrc' to apply changes" 