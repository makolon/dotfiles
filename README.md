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
- **Notes**: [Obsidian](https://obsidian.md/) - Markdown knowledge base (macOS GUI app via Homebrew cask)
- **AI Assistant**: [OpenClaw](https://github.com/openclaw/openclaw) - Self-hosted personal AI agent (manual npm install — see the OpenClaw section below)

## 🚀 Quick Start

### Prerequisites

- macOS (tested on recent versions)
- [Nix](https://nixos.org/) — installed automatically via the [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer) for CLI tools
- [Homebrew](https://brew.sh/) — installed automatically for macOS GUI apps and platform-specific formulae

### Installation

1. Install chezmoi and initialize your dotfiles:

   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply makolon/dotfiles
   ```

   This will:
   - Install chezmoi if not already installed
   - Clone this repository
   - Run the setup scripts (install Nix + CLI packages, Homebrew casks, configure Fish shell, etc.)
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

CLI tools are managed declaratively via `flake.nix` with pinned versions (`flake.lock`). macOS GUI apps use Homebrew casks.

**Nix Packages (CLI tools, declared in `flake.nix`):**
- fish
- neovim
- neofetch
- fastfetch
- starship
- fzf
- ghq
- peco
- nodejs (Node.js 24 — runtime for OpenClaw's `npm install -g`)

**Homebrew Casks (macOS GUI apps):**
- aerospace
- kitty
- ghostty
- obsidian

**Homebrew — FelixKratz Formulae (macOS-only):**
- borders
- sketchybar

## 🤖 OpenClaw (optional, manual install)

[OpenClaw](https://github.com/openclaw/openclaw) is a self-hosted personal AI
assistant. It is intentionally **not auto-installed** by the setup scripts. Node.js
is provided via `flake.nix`, and the npm global prefix (`~/.npm-global`) is set in
the Fish config, so you install and onboard OpenClaw yourself whenever you want it:

```bash
# Node.js 24 comes from Nix; npm global installs go to ~/.npm-global (on PATH).
npm install -g openclaw@latest

# Guided setup: workspace, channels, skills, and (optionally) the always-on daemon.
openclaw onboard --install-daemon
```

You'll need an API key from your chosen model provider. OpenClaw keeps its config
and state under its own directory (e.g. `~/.openclaw`), which is **not** tracked in
this repo — keep credentials out of version control, the same as any other secret.

> Requires Node 24 (recommended) or Node 22.19+. If `npm install -g` reports a
> read-only path, confirm `echo $NPM_CONFIG_PREFIX` points at `~/.npm-global` (set
> by the Fish config) and that `~/.npm-global/bin` is on your `PATH`.

## 🔧 Updating

To update your dotfiles:

```bash
# Pull the latest changes and apply them
chezmoi update

# Or do it in two steps
chezmoi git pull
chezmoi apply
```

### Updating Nix packages

To update Nix packages to the latest versions in the pinned nixpkgs:

```bash
nix profile upgrade '.*'
```

To bump the nixpkgs pin itself (e.g. to get newer package versions):

```bash
cd $(chezmoi source-path)
nix flake update
nix profile upgrade '.*'
```

> **Note:** `flake.lock` is generated on first install and should be committed to pin exact package versions. If it doesn't exist yet, `nix profile install` will create it automatically.

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
├── flake.nix                             # Declarative Nix package list
├── flake.lock                            # Pinned nixpkgs revision
├── run_once_install-packages.sh.tmpl     # Package installation script
├── run_once_after_setup-fish.sh.tmpl     # Fish shell setup script
└── private_dot_config/                   # ~/.config directory
    ├── exact_aerospace/                  # AeroSpace configuration
    ├── exact_borders/                    # JankyBorders configuration
    ├── exact_fastfetch/                  # Fastfetch configuration
    ├── exact_fish/                       # Fish shell configuration
    ├── exact_ghostty/                    # Ghostty terminal configuration
    ├── exact_kitty/                      # Kitty terminal configuration
    ├── exact_neofetch/                   # Neofetch configuration
    ├── exact_sketchybar/                 # SketchyBar configuration
    ├── exact_starship/                   # Starship prompt configuration
    └── exact_tmux/                       # Tmux configuration
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
