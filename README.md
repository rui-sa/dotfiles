# Rui's Dotfiles

Personal configuration files and setup scripts for macOS development environment.

## 🚀 Quick Setup (New Machine)

1. **Clone this repository:**
   ```bash
   git clone https://github.com/your-username/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the setup script:**
   ```bash
   chmod +x setup_new_machine.sh
   ./setup_new_machine.sh
   ```

This will automatically:
- Install Homebrew and Oh My Zsh
- Install all your packages and applications
- Install Python versions via pyenv
- Install Cursor extensions
- Create symlinks for all configuration files
- Generate SSH keys if needed

## 📁 What's Included

### Shell Configuration
- `zshrc` - Zsh configuration with Oh My Zsh
- `zprofile` - Zsh profile settings
- `aliases` - Custom command aliases

### Development Tools
- `gitconfig` - Git configuration
- `settings.json` - VS Code/Cursor settings
- `keybindings.json` - VS Code/Cursor keybindings
- `cursor_mcp.json` - Cursor MCP server configuration

### SSH & Security
- `config` - SSH configuration
- SSH key generation and setup

### Package Lists
- `brew_packages.txt` - Homebrew formula packages
- `brew_casks.txt` - Homebrew cask applications
- `pyenv_versions.txt` - Python versions
- `cursor_extensions.txt` - Cursor extensions

## 🔧 Manual Setup (Individual Components)

If you prefer to set up components individually:

### Install dotfiles only:
```bash
./install.sh
```

### Install Homebrew packages:
```bash
brew install $(cat brew_packages.txt)
brew install --cask $(cat brew_casks.txt)
```

### Install Python versions:
```bash
while read version; do pyenv install $version; done < pyenv_versions.txt
```

### Install Cursor extensions:
```bash
while read ext; do cursor --install-extension $ext; done < cursor_extensions.txt
```

## 🔄 Updating Configurations

Since all config files are symlinked to this repository:
1. Edit any config file normally (e.g., `~/.zshrc`)
2. Changes are automatically tracked in git
3. Commit and push changes:
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Update configurations"
   git push
   ```

## 📋 Before Switching Machines

Run this to update all package lists:
```bash
cd ~/dotfiles
brew list --formula > brew_packages.txt
brew list --cask > brew_casks.txt
pyenv versions --bare > pyenv_versions.txt
# Update cursor_extensions.txt manually if needed
git add . && git commit -m "Update package lists" && git push
```

## 🛠 Troubleshooting

### Symlinks not working?
The install script automatically detects the dotfiles directory location, so it works whether you clone to `~/dotfiles` or any other location.

### Missing packages?
Check if the package lists are up to date and run the setup script again.

### SSH issues?
Make sure to add your SSH public key to GitHub/GitLab after running the setup script.

## 📱 Manual Steps After Setup

1. **Sign into accounts:**
   - Google Drive
   - iCloud
   - Development accounts

2. **Configure app-specific settings:**
   - Terminal color schemes
   - Browser bookmarks and extensions
   - Any proprietary software licenses

3. **Install Mac App Store apps manually**

4. **Set up any company-specific configurations**
