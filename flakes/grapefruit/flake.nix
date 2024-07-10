{
  description = "julia's dev env";
  inputs = {
      # copy from https://github.com/NixOS/nixpkgs/commits/nixpkgs-23.11-darwin/
      #nixpkgs.url = "github:NixOS/nixpkgs/700804df18b73e2fe360d950f371aaec1691dea2";
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";

      # copy from https://github.com/NixOS/nixpkgs/commits/nixpkgs-unstable/
      #nixpkgsUnstable.url = "github:NixOS/nixpkgs/98b00b6947a9214381112bdb6f89c25498db4959";
      nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs, nixpkgsUnstable }: 
    let pkgs = import nixpkgs {
      system = "aarch64-darwin";
      config.allowUnfree = true;
    };
    unstablePkgs = import nixpkgsUnstable {
      system = "aarch64-darwin";
      config.allowUnfree = true;
    };
    myHugo = import ./hugo-0.40.nix { pkgs = pkgs; };
    myPaperjam = import ./paperjam.nix { pkgs = pkgs; };
    myPicat = import ./picat.nix { pkgs = pkgs; };
    mydnsdist = import ./dnsdist.nix { pkgs = pkgs; };
    mypdns = import ./pdns.nix { pkgs = pkgs; };
    in 
{
    defaultPackage.aarch64-darwin = pkgs.buildEnv {
      name = "julia-dev";
      paths = with pkgs; [
        myPaperjam
        myHugo
        unstablePkgs.nix-output-monitor
        nixos-rebuild
        ];
        pathsToLink = [ "/share/man" "/share/doc" "/bin" "/lib" "include"];
        extraOutputsToInstall = [ "man" "doc" ];
      };
    };
  }
