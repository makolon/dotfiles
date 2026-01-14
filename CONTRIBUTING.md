# Contributing to dotfiles

Thank you for your interest in contributing to this dotfiles repository!

## Understanding chezmoi

This repository uses [chezmoi](https://www.chezmoi.io/) to manage dotfiles. Before contributing, please familiarize yourself with chezmoi's concepts:

- **Source state**: Files in this repository (with special naming conventions)
- **Target state**: Actual files in your home directory
- **Attributes**: Special prefixes and suffixes that control how files are processed

## File Naming Conventions

chezmoi uses special prefixes and suffixes:

### Prefixes

- `dot_`: Adds a leading dot (e.g., `dot_gitconfig` → `~/.gitconfig`)
- `private_`: Sets permissions to 600 for files, 700 for directories
- `executable_`: Makes the file executable
- `run_once_`: Script runs once
- `run_once_after_`: Script runs once after applying dotfiles
- `create_`: Creates file if it doesn't exist, but doesn't overwrite
- `modify_`: Script that modifies an existing file
- `exact_`: Removes any files not managed by chezmoi from the directory

### Suffixes

- `.tmpl`: File is treated as a template

### Examples

- `private_dot_config/fish/config.fish` → `~/.config/fish/config.fish` (with 700 permissions)
- `executable_colors.sh` → `colors.sh` (with execute permissions)
- `run_once_install-packages.sh.tmpl` → Runs once during setup

## Making Changes

### Editing Configuration Files

1. Use chezmoi edit command:
   ```bash
   chezmoi edit ~/.config/fish/config.fish
   ```

2. Or directly edit in the source directory:
   ```bash
   chezmoi cd
   # Edit files
   exit
   ```

3. Apply changes:
   ```bash
   chezmoi apply
   ```

### Adding New Files

To add a new dotfile:

```bash
# Add a file from your home directory
chezmoi add ~/.newconfig

# Or create directly in source directory
chezmoi cd
# Create/edit files following naming conventions
exit
```

### Adding New Packages

To add new Homebrew packages:

1. Edit `run_once_install-packages.sh.tmpl`
2. Add the package to the appropriate array:
   - `packages` for formulae
   - `casks` for cask applications
3. Test the installation script

### Working with Templates

Templates use Go's `text/template` syntax and have access to chezmoi's template functions:

```bash
# Example: Access user data
{{ .email }}
{{ .name }}

# Example: OS-specific configuration
{{ if eq .chezmoi.os "darwin" }}
# macOS specific
{{ end }}

# Example: Execute command
{{ output "brew" "--prefix" }}
```

## Testing Changes

Before submitting:

1. Test in a safe environment:
   ```bash
   # Preview changes
   chezmoi diff
   
   # Dry run
   chezmoi apply --dry-run --verbose
   ```

2. Verify file permissions:
   ```bash
   chezmoi verify
   ```

3. Check for errors:
   ```bash
   chezmoi doctor
   ```

## Pull Request Process

1. Fork the repository
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes following the conventions above
4. Test thoroughly
5. Commit with clear messages:
   ```bash
   git commit -m "Add: Brief description of changes"
   ```
6. Push to your fork and submit a Pull Request

### Commit Message Format

- `Add:` Adding new features or files
- `Update:` Modifying existing configuration
- `Fix:` Bug fixes
- `Docs:` Documentation changes
- `Refactor:` Code refactoring without functionality changes

## Common Tasks

### Adding a New Application Configuration

1. Place config files in `private_dot_config/app-name/`
2. Use appropriate prefixes (e.g., `executable_` for scripts)
3. Update `run_once_install-packages.sh.tmpl` if the app needs to be installed
4. Document the application in `README.md`

### Updating Installation Scripts

When modifying `run_once_install-packages.sh.tmpl`:

- Keep idempotency in mind (scripts should be safe to run multiple times)
- Check if packages are already installed before installing
- Provide clear output messages
- Handle errors gracefully

### Managing Secrets

Never commit secrets directly! Use one of these approaches:

1. **Environment variables**:
   ```
   {{ env "SECRET_KEY" }}
   ```

2. **Prompt during init**:
   ```
   {{- $secret := promptStringOnce . "secret" "Enter secret" -}}
   ```

3. **External secret manager** (1Password, etc.):
   ```
   {{ onepassword "item-id" }}
   ```

## Style Guide

- Use 2 or 4 spaces for indentation (be consistent within a file)
- Keep lines under 100 characters when possible
- Comment complex configurations
- Use descriptive variable names in templates
- Follow the existing code style in each file

## Getting Help

- [chezmoi Documentation](https://www.chezmoi.io/)
- [chezmoi GitHub](https://github.com/twpayne/chezmoi)
- Open an issue for questions or problems

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.
