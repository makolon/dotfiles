fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# theme
set fish_theme agnoster

# peco & ghz + fzf
function fish_user_key_bindings
  # History search via peco bind \cr 'peco_select_history (commandline -b)'
  bind \c] peco_select_ghq_repository

  # ghq + fzf repo switch
  bind \cg ghq_fzf_repo
end

# ghq + fzf
function ghq_fzf_repo -d 'Repository search'
  ghq list --full-path | fzf --reverse --height=100% | read select
  [ -n "$select" ]; and cd "$select"
  echo " $select "
  commandline -f repaint
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

# color
set -gx TERM xterm-256color
set -gx COLORTERM truecolor

# develp terminal
function kdev
  # Make the current window deterministic
  kitty @ set-window-title "Editor"
  kitty @ goto-layout splits

  # 1) Right-top: Codex
  kitty @ launch \
    --location=vsplit \
    --type=window \
    --title="Codex" \
    --cwd "$PWD" \
    fish -lc "codex"

  # 2) Split the Codex window horizontally to create right-bottom, then run lazygit there
  kitty @ focus-window --match title:Codex
  kitty @ launch \
    --location=hsplit \
    --type=window \
    --title="lazygit" \
    --cwd "$PWD" \
    fish -lc "lazygit"

  # 3) Back to left, open Neovim in current directory
  kitty @ focus-window --match title:Editor
  nvim .
end
