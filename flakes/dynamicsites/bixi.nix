{ pkgs ? (import <nixpkgs> { }), lib, stdenv, ... }: 
let bixi = pkgs.callPackage pkgs.stdenv.mkDerivation {
  name = "bixi-cache";
  src = fetchGit {
    url = "git@github.com:jvns/biximap2.git";
    rev = "8bd96bd77f3b671323c98df1d27422900f3a8cc6";
  };
  buildInputs = [ pkgs.go ];
  GOCACHE = "/tmp/go-cache"; /* todo: this is probably wrong */
  buildPhase = "go build cache.go";
  installPhase = "mkdir -p \$out/bin && cp cache \$out/bin";
}; in { 
  users.extraUsers.bixi = {
    name = "bixi";
    group = "bixi";
    uid = 1004;
    home = "/var/empty";
    isSystemUser = true;
  };
  users.extraGroups.bixi = {
    name = "bixi";
    gid = 1004;
  };


  systemd.services.bixi-cache = {
    enable = true;
    description = "bixi-cache";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    script = "${bixi}/bin/cache";
    serviceConfig = {
      User = "bixi";
    };
  };
}
