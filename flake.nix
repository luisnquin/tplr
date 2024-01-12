{
  description = "Error ocurred at 224, too specific.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    flake-utils,
    nixpkgs,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        packages = {
          tplr = pkgs.callPackage ./default.nix {};
        };
      in {
        inherit packages;

        defaultPackage = packages.tplr;
      }
    );
}
