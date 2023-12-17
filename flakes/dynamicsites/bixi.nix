{ pkgs ? (import <nixpkgs> { }), lib, stdenv, ... }: 
let bixi = pkgs.callPackage pkgs.stdenv.mkDerivation {
  name = "bixi-cache";
  src = fetchGit {
    url = "git@github.com:jvns/biximap2.git";
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

  services.caddy.virtualHosts."bixi.jvns.ca".extraConfig = ''
    reverse_proxy localhost:8999
  '';

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
