{ lib
, buildGoModule
, buildGo125Module ? null
, version ? "dev"
}:

let
  goBuilder =
    if buildGo125Module != null then buildGo125Module else buildGoModule;
in
goBuilder rec {
  pname = "engram";
  inherit version;

  src = lib.cleanSource ../.;

  subPackages = [ "cmd/engram" ];
  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  env.CGO_ENABLED = 0;

  vendorHash = "sha256-5nSAU7L2Xv9dzJln47Zb6dv1YCPAXXGg6wCzNIpIn9U=";

  # Test suite includes integration tests that expect extra services.
  doCheck = false;

  meta = with lib; {
    description = "Persistent memory for AI coding agents";
    homepage = "https://github.com/Gentleman-Programming/engram";
    license = licenses.mit;
    mainProgram = "engram";
    platforms = platforms.unix;
  };
}
