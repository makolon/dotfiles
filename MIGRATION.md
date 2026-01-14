# Migration to chezmoi

This document explains the migration from a traditional dotfiles structure to chezmoi.

## What Changed

### Directory Structure

**Before:**
```
dotfiles/
├── aerospace/
├── borders/
├── fastfetch/
├── fish/
├── ghostty/
├── kitty/
├── neofetch/
├── sketchybar/
└── starship/
```

**After:**
```
dotfiles/
├── .chezmoi.toml.tmpl                    # Config template
├── .chezmoiignore                        # Ignore patterns
├── .gitignore                            # Git ignore
├── README.md                             # Main documentation
├── CONTRIBUTING.md                       # Contribution guide
├── run_once_install-packages.sh.tmpl     # Package installer
├── run_once_after_setup-fish.sh.tmpl     # Fish shell setup
└── private_dot_config/                   # ~/.config directory
    ├── aerospace/
    ├── borders/
    ├── fastfetch/
    ├── fish/
    ├── ghostty/
    ├── kitty/
    ├── neofetch/
    ├── sketchybar/
    └── starship/
```

### Key Changes

1. **Directory Renamed**: All config directories moved to `private_dot_config/`
   - This maps to `~/.config/` with proper permissions (700)
   - The `private_` prefix ensures correct permissions

2. **Executable Files**: Scripts marked with `executable_` prefix
   - `sketchybarrc` → `executable_sketchybarrc`
   - Shell scripts in `sketchybar/items/` and `sketchybar/plugins/`
   - Python scripts in `kitty/` (if they were executable)

3. **New Configuration Files**:
   - `.chezmoi.toml.tmpl`: Prompts for email and name on first run
   - `.chezmoiignore`: Prevents README and other files from being copied to home
   - `.gitignore`: Prevents chezmoi state and system files from being committed

4. **Automated Setup Scripts**:
   - `run_once_install-packages.sh.tmpl`: Installs all Homebrew packages
   - `run_once_after_setup-fish.sh.tmpl`: Configures Fish as default shell

## Benefits of chezmoi

### 1. Automated Installation
Instead of manually copying files and installing packages, run:
```bash
chezmoi init --apply <your-github-username>/dotfiles
```

### 2. Cross-Machine Synchronization
```bash
# On machine A: make changes
chezmoi edit ~/.config/fish/config.fish
chezmoi cd && git commit && git push

# On machine B: apply changes
chezmoi update
```

### 3. Template Support
Files with `.tmpl` extension can use Go templates:
```bash
# Different configs per machine
{{ if eq .chezmoi.os "darwin" }}
# macOS specific
{{ end }}

# User-specific data
email = {{ .email }}
```

### 4. Idempotent Scripts
`run_once_` scripts only run once per machine, tracked by chezmoi

### 5. Safe Updates
Preview changes before applying:
```bash
chezmoi diff          # See what would change
chezmoi apply --dry-run --verbose  # Test run
chezmoi apply         # Apply changes
```

### 6. Proper Permissions
The `private_` prefix automatically sets:
- Directories: 700 (rwx------)
- Files: 600 (rw-------)

### 7. Executable Management
The `executable_` prefix automatically marks files as executable without manual `chmod`

## Migration Steps Performed

1. ✅ Created `private_dot_config/` directory
2. ✅ Moved all config directories into `private_dot_config/`
3. ✅ Renamed executable scripts with `executable_` prefix
4. ✅ Created `.chezmoi.toml.tmpl` for user configuration
5. ✅ Created `.chezmoiignore` to exclude repository files
6. ✅ Created `.gitignore` for version control
7. ✅ Created automated installation script
8. ✅ Created Fish shell setup script
9. ✅ Updated README.md with chezmoi instructions
10. ✅ Created CONTRIBUTING.md for developers

## Usage

### First Time Setup
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply <username>/dotfiles
```

### Daily Operations
```bash
# Edit a config file
chezmoi edit ~/.config/fish/config.fish

# See what would change
chezmoi diff

# Apply changes
chezmoi apply

# Commit and push
chezmoi cd
git add .
git commit -m "Update configuration"
git push
```

### On Another Machine
```bash
# Pull and apply latest changes
chezmoi update
```

## Troubleshooting

### Need to re-run setup scripts?
```bash
# Remove chezmoi state to re-run scripts
chezmoi state reset

# Then apply again
chezmoi apply
```

### Want to see what chezmoi manages?
```bash
chezmoi managed
```

### Check for issues
```bash
chezmoi doctor
```

## Resources

- [chezmoi Documentation](https://www.chezmoi.io/)
- [chezmoi User Guide](https://www.chezmoi.io/user-guide/)
- [Source State Attributes](https://www.chezmoi.io/reference/source-state-attributes/)
