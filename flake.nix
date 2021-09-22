{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      inherit (flake-utils.lib)
        defaultSystems
        eachSystem
      ;
    in
    {
      overlay = final: prev: {
        foo = import ./derivations/foo.nix { pkgs = final; };
        bar = import ./derivations/bar.nix { pkgs = final; };
      };

    } // eachSystem defaultSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        };
      in
      {
        packages = { inherit (pkgs) foo bar; };
      });
}
