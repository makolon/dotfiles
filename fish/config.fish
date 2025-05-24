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

# neofetch
function neo
  neofetch
end

# starship
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source

