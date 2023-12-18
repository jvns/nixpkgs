{ pkgs ? (import <nixpkgs> { }), lib, stdenv, ... }: 
let feedback = pkgs.callPackage pkgs.buildGoModule {
  name = "zine-feedback";
  src = fetchGit {
    url = "git@github.com:jvns/zine-feedback.git";
    rev = "efcc67c6b0abd90fb2bd92ef888e4bd9c5c50835";

  };
  vendorHash = "sha256-b+mHu+7Fge4tPmBsp/D/p9SUQKKecijOLjfy9x5HyEE";
}; in { 
  users.extraUsers.feedback = {
    name = "feedback";
    group = "feedback";
    uid = 1005;
    home = "/var/empty";
    isSystemUser = true;
  };
  users.extraGroups.feedback = {
    name = "feedback";
    gid = 1005;
  };

  services.caddy.virtualHosts."feedback.jvns.ca".extraConfig = ''
    reverse_proxy localhost:8333
  '';
  /* create /data/zine-feedback directory */

  systemd.tmpfiles.rules = [
    /* - at the end meand don't clean up on reboot */
    "d /data/zine-feedback 0755 feedback feedback -"
  ];

  systemd.services.zine-feedback = {
    enable = true;
    description = "zine-feedback";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    script = "${feedback}/bin/zine-feedback";
    environment = {
      DB_FILENAME = "/data/zine-feedback/db.sqlite";
    };
    serviceConfig = {
      User = "feedback";
    };
  };
}
