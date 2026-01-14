fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# theme
set fish_theme agnoster

# peco
function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \c] peco_select_ghq_repository
end

# ghq + fzf
function ghq_fzf_repo -d 'Repository search'
  ghq list --full-path | fzf --reverse --height=100% | read select
  [ -n "$select" ]; and cd "$select"
  echo " $select "
  commandline -f repaint
end

# fish key bindings
function fish_user_key_bindings
  bind \cg ghq_fzf_repo
end

# neovim
function n
  nvim $argv
end
function vim
  nvim $argv
end

# fastfetch
function fast
  fastfetch
end

# starship
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source

function kdev
  # 1. Set title for the current window
  kitty @ set-window-title "Editor"

  # 2. Ensure we are using 'splits' layout
  kitty @ goto-layout splits

  # 3. Launch Claude Code (Right side)
  kitty @ launch --location=vsplit --type=window fish -c "claude"

  # 4. Launch a Terminal in a horizontal split (Bottom Right)
  # This splits the Claude window (which is currently focused)
  kitty @ launch --location=hsplit --type=window fish

  # 5. Focus back to the first window
  kitty @ focus-window --match nthe:0

  # 6. Start nvim
  nvim .
end
