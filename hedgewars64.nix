{ pkgs }:
let
  version = "1.0.3-unstable-2025-06-26";
in
pkgs.hedgewars.overrideAttrs (oldAttrs: {
  inherit version;

  src = pkgs.fetchFromGitHub {
    owner = "yeoldegrove";
    repo = "hedgewars";
    rev = "feat/64";
    hash = "sha256-mFW8H3x/Gv2WzDt4m3IFd1KarAEpn0tG3NNVF65N9/Y=";
  };
})
