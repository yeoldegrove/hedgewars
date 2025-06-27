{
  description = "Hedgewars - A turn-based strategy game";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        hedgewars64 = import ./hedgewars64.nix { inherit pkgs; };

      in
      {
        packages = {
          default = hedgewars64;
          hedgewars = hedgewars64;
        };

        apps = {
          default = {
            type = "app";
            program = "${hedgewars64}/bin/hedgewars";
          };
          hedgewars = {
            type = "app";
            program = "${hedgewars64}/bin/hedgewars";
          };
          hwengine = {
            type = "app";
            program = "${hedgewars64}/bin/hwengine";
          };
          hedgewars-server = {
            type = "app";
            program = "${hedgewars64}/bin/hedgewars-server";
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Development tools
            cmake
            pkg-config
            makeWrapper

            # Build dependencies
            fpc
            qt5.qtbase
            qt5.qttools
            lua5_1

            # SDL2 libraries
            SDL2
            SDL2_net
            SDL2_mixer
            SDL2_image
            SDL2_ttf

            # Other dependencies
            physfs
            libpng
            zlib
            ffmpeg
            glew

            # Development tools
            gdb
            valgrind
            git
          ];

          shellHook = ''
            echo "🎮 Hedgewars development environment"
            echo "Available commands:"
            echo "  nix build     - Build Hedgewars"
            echo "  nix run       - Run the game"
            echo "  nix run .#hwengine - Run the engine"
            echo "  nix run .#hedgewars-server - Run the server"
          '';
        };
      }
    );
}
