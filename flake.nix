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
              # Node.js runtime — prerequisite for OpenClaw (`npm install -g openclaw`,
              # recommended Node 24). If nodejs_24 is absent in the pinned nixpkgs,
              # fall back to nodejs_22 (OpenClaw supports 22.19+).
              nodejs_24
            ];
          };
        }
      );
    };
}
