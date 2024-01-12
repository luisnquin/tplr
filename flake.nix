{
  description = "Error ocurred at 224, too specific.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
  };

  outputs = inputs @ {
    self,
    systems,
    nixpkgs,
    ...
  }: let
    inherit (nixpkgs) lib;
    eachSystem = lib.genAttrs (import systems);
  in rec {
    packages = eachSystem (system: rec {
      pkgs = import nixpkgs {
        localSystem = system;
      };

      tplr = pkgs.callPackage ./default.nix {};
      default = tplr;
    });

    homeManagerModules.default = import ./nix/hm-module.nix self;
  };
}
