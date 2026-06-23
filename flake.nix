{
  description = "Makolon's CLI tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems f;
    in {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          # Core CLI environment — always installed (`nix profile add path:.`).
          default = pkgs.buildEnv {
            name = "makolon-cli";
            paths = with pkgs; [
              fish
              neovim
              neofetch
              fastfetch
              starship
              fzf
              ghq
              peco
            ];
          };

          # Optional, individually selectable Nix packages. The package picker in
          # run_once_install-packages.sh.tmpl installs the chosen ones via
          # `nix profile add path:.#<name>`. To add one: expose it here and add a
          # matching `nix` line to that script's `optional_items` manifest.
          bat = pkgs.bat;
          htop = pkgs.htop;
        }
      );
    };
}
