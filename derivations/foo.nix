{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) autoreconfHook stdenv;
in
stdenv.mkDerivation rec {
  name = "hello";

  src = ./../foo/src;

  nativeBuildInputs = [ autoreconfHook ];
}
