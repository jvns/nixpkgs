{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    ./bixi.nix
    ./zine-feedback.nix
  ];

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "dynamicsites-nix";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXH/3l4T01fzgmdSsg6tfWmIkfTxm6uPIRqOIf3CLMrtJhQZcT6Rq7TyUzktbglOqg1YDsy6asXsKFpDAqTFNOIx/cPj3Bj/PZ7uUv5VHdnCTL+Y1KnjnDhag7K6txgLMjypTcYWByJRpG2462CuH3qvKB7AD0y60L/CbJZ0HYzVfIGLsWA1XwrQqevkCIz1udZT2LF3JMci579bSuzpoqTDxK7o+8FCA6XD5eH2v8NNo9Bd1VfTy1PjR+MD9wPGgmVA1lzlLDZiVbiyF09kI3Nyb/fm4iU6+TQKy6K0Al+bWKjoOOTYmdwymVspCwGy/CE07FyBTKxLZgFZ1Vjg3EaUPysg8YLL0bys1kMy6P2RsXKq29/GXtp3hRn9eSLgP42IZglag792PcymkNJ+odFEymvh16ojogsSLorN3KSIdzazPBhwxtowXft4riljhXkITt5gAXrihVewFBZrHEQzxJYTlJ/QkO14fP2gjHaEBc4v0QEhGr098y1GJGLvM='' ];
  services.caddy = {
    enable = true;
    virtualHosts."localhost".extraConfig = ''
      respond "Hello, world!"
    '';
  };
}
