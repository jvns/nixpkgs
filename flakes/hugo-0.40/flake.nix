{
  description = "A flake for Hugo 0.40.3";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
  outputs = { self, nixpkgs }: {
    defaultPackage.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.buildGoPackage rec {
          pname = "hugo040";
          version = "0.40.3";

          goPackagePath = "github.com/gohugoio/hugo";

          src = nixpkgs.legacyPackages.aarch64-darwin.fetchFromGitHub {
            owner  = "gohugoio";
            repo   = "hugo";
            rev    = "v${version}";
            sha256 = "08d4y6x19cd4qy9pf80zrqarcyarbzxph0yp8mfb1sp2bvq42308";
          };

          postInstall = ''
            mv $out/bin/hugo $out/bin/hugo-040
          '';
          goDeps = ./hugo-deps.nix;

          meta = with  nixpkgs.legacyPackages.aarch64-darwin.lib; {
            description = "A fast and modern static website engine.";
            homepage = https://gohugo.io;
            license = licenses.asl20;
          };
        };
    };
  }
