# Makolon's dotfiles

## 🍺 Features

- [aerospace](https://github.com/nikitabobko/AeroSpace)

    ```bash
    brew install --cask nikitabobko/tap/aerospace
    ```

- [borders](https://github.com/FelixKratz/JankyBorders)

    ```bash
    brew tap FelixKratz/formulae && brew install borders
    ```

- [fish](https://github.com/fish-shell/fish-shell)

    ```bash
    brew install fish
    ```

- [htop](https://github.com/htop-dev/htop)

    ```bash
    brew install htop
    ```

- [jq](https://github.com/jqlang/jq)

    ```bash
    brew install jq
    ```

- [kitty](https://github.com/kovidgoyal/kitty)

    ```bash
    brew install --cask kitty
    ```

- [neofetch](https://github.com/dylanaraps/neofetch)

    ```bash
    brew install neofetch
    ```

- [neovim](https://github.com/neovim/neovim)

    ```bash
    brew install neovim
    ```

- [sketchybar](https://github.com/FelixKratz/SketchyBar)

    ```bash
    brew tap FelixKratz/formulae && brew install sketchybar
    ```

## ⚙️ Configuration

### Example: SketchyBar

1. Clone dotfiles from the repository:

    ```bash
    git clone https://github.com/SoichiroYamane/dotfiles.git
    mv ~/.config/sketchybar ~/.config/sketchybar.bak
    cp -r ./dotfiles/sketchybar ~/.config/sketchybar
    ```

2. Install assets for this sketchybar.

    ```bash
    cd ~/.config/sketchybar/helpers
    ./install.sh
    ```

3. Restart sketchybar

    ```bash
    brew services restart sketchybar
    ```
