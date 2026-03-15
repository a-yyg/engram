{ pkgs ? import <nixpkgs> { } }:
let
  engram = pkgs.callPackage ./nix/package.nix { };
in
{
  default = engram;
  engram = engram;
}
