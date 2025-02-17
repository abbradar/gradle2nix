{
  description = "Wrap Gradle builds with Nix";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        packages.gradle2nix = import ./default.nix { inherit pkgs; };
        defaultPackage = packages.gradle2nix;

        apps.gradle2nix = {
          type = "app";
          program = "${packages.gradle2nix}/bin/gradle2nix";
        };
        defaultApp = apps.gradle2nix;
      }
    );
}
