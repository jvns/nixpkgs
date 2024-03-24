{ pkgs, ... }:  
with pkgs;

buildGoPackage rec {
  name = "hugo040";
  version = "0.40.3";

  goPackagePath = "github.com/gohugoio/hugo";

  src = fetchFromGitHub {
    owner  = "gohugoio";
    repo   = "hugo";
    rev    = "v${version}";
    sha256 = "08d4y6x19cd4qy9pf80zrqarcyarbzxph0yp8mfb1sp2bvq42308";
  };
# rename binary after install

  postInstall = ''
    mv $out/bin/hugo $out/bin/hugo-0.40
  '';
  goDeps = ./hugo-deps.nix;

  meta = with lib; {
    description = "A fast and modern static website engine.";
    homepage = https://gohugo.io;
    license = licenses.asl20;
    maintainers = with maintainers; [ schneefux ];
  };
}

