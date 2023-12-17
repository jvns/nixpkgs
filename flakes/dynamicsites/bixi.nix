{ lib, ... }: {
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
    enable = false;
    description = "bixi-cache";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "/deploy/bixi-cache/bixi-cache";
      WorkingDirectory = "/deploy/bixi-cache";
      User = "bixi";
    };
  };
}
