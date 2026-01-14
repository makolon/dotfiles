# Makolon's dotfiles

Manage your dotfiles with [chezmoi](https://www.chezmoi.io/).

## ✨ Features

This dotfiles repository includes configurations for:

- **Window Management**: [AeroSpace](https://github.com/nikitabobko/AeroSpace) - Tiling window manager for macOS
- **Window Borders**: [JankyBorders](https://github.com/FelixKratz/JankyBorders) - Customizable window borders
- **Status Bar**: [SketchyBar](https://github.com/FelixKratz/SketchyBar) - Highly customizable macOS status bar
- **Terminal**: [Kitty](https://github.com/kovidgoyal/kitty) & [Ghostty](https://github.com/ghostty-org/ghostty) - GPU-accelerated terminal emulators
- **Shell**: [Fish](https://github.com/fish-shell/fish-shell) - User-friendly command line shell
- **Editor**: [Neovim](https://github.com/neovim/neovim) - Hyperextensible Vim-based text editor
- **Prompt**: [Starship](https://starship.rs/) - Minimal, fast, and customizable prompt
- **System Info**: [Fastfetch](https://github.com/fastfetch-cli/fastfetch) & [Neofetch](https://github.com/dylanaraps/neofetch)

## 🚀 Quick Start

### Prerequisites

- macOS (tested on recent versions)
- [Homebrew](https://brew.sh/) will be installed automatically if not present

### Installation

1. Install chezmoi and initialize your dotfiles:

   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply makolon/dotfiles
   ```

   This will:
   - Install chezmoi if not already installed
   - Clone this repository
   - Run the setup scripts (install Homebrew packages, configure Fish shell, etc.)
   - Apply all dotfiles to your home directory

2. The setup will prompt you for:
   - Your email address
   - Your full name

3. Restart your terminal to use Fish as your default shell.

### Manual Installation

If you prefer to install manually:

```bash
# Install chezmoi
brew install chezmoi

# Initialize chezmoi with this repository
chezmoi init makolon/dotfiles

# Preview what changes will be made
chezmoi diff

# Apply the changes
chezmoi apply
```

## 📦 What Gets Installed

The `run_once_install-packages.sh` script will automatically install:

**Homebrew Formulae:**
- fish
- neovim
- neofetch
- fastfetch
- starship
- fzf
- ghq
- peco

**Homebrew Casks:**
- aerospace
- kitty
- ghostty

**FelixKratz Formulae:**
- borders
- sketchybar

## 🔧 Updating

To update your dotfiles:

```bash
# Pull the latest changes and apply them
chezmoi update

# Or do it in two steps
chezmoi git pull
chezmoi apply
```

## 📝 Making Changes

To edit a dotfile:

```bash
# Edit with your default editor
chezmoi edit ~/.config/fish/config.fish

# Or open the source directory
chezmoi cd
```

After making changes:

```bash
# Apply changes
chezmoi apply

# Add and commit changes
chezmoi cd
git add .
git commit -m "Update configuration"
git push
```

## 🗂️ Repository Structure

```
.
├── .chezmoi.toml.tmpl                    # Chezmoi configuration template
├── .chezmoiignore                        # Files to ignore
├── run_once_install-packages.sh.tmpl     # Package installation script
├── run_once_after_setup-fish.sh.tmpl     # Fish shell setup script
└── private_dot_config/                   # ~/.config directory
    ├── aerospace/                        # AeroSpace configuration
    ├── borders/                          # JankyBorders configuration
    ├── fastfetch/                        # Fastfetch configuration
    ├── fish/                             # Fish shell configuration
    ├── ghostty/                          # Ghostty terminal configuration
    ├── kitty/                            # Kitty terminal configuration
    ├── neofetch/                         # Neofetch configuration
    ├── sketchybar/                       # SketchyBar configuration
    └── starship/                         # Starship prompt configuration
```

## 🔒 Security

- The `.chezmoiignore` file prevents sensitive files from being added to the repository
- Configuration directories use the `private_` prefix to ensure correct permissions (700/600)

## 🆘 Troubleshooting

### Fish shell not set as default

If Fish wasn't automatically set as your default shell:

```bash
# Find fish path
which fish

# Add to /etc/shells if not present
echo $(which fish) | sudo tee -a /etc/shells

# Set as default shell
chsh -s $(which fish)
```

### SketchyBar not working

After applying the dotfiles:

```bash
# Restart SketchyBar
brew services restart sketchybar

# If you have custom helpers, install them
cd ~/.config/sketchybar/helpers
./install.sh
```

## 📚 Resources

- [chezmoi Documentation](https://www.chezmoi.io/)
- [chezmoi Quick Start](https://www.chezmoi.io/quick-start/)
- [Fish Shell Documentation](https://fishshell.com/docs/current/)
- [Neovim Documentation](https://neovim.io/doc/)

## 📄 License

Feel free to use and modify these dotfiles for your own use.
