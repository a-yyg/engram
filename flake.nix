{
  description = "Engram - persistent memory for AI coding agents";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          version = if self ? shortRev then self.shortRev else "dev";
          engram = pkgs.callPackage ./nix/package.nix { inherit version; };
        in
        {
          default = engram;
          engram = engram;
        });
    };
}
