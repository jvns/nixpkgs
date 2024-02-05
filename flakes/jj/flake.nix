{
  description = "A flake for jj";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";

  outputs = { self, nixpkgs }: {
    defaultPackage.aarch64-darwin = with nixpkgs.legacyPackages.aarch64-darwin; builtins.derivation {
      name = "jujutsu";
      builder = ./unpack-jj.sh;
      system = builtins.currentSystem;
      PATH = "${pkgs.gnutar}/bin:${pkgs.gzip}/bin:${pkgs.coreutils}/bin";
      # add libgit2 to the runtime dependencies
      buildInputs = [ pkgs.libgit2 ];


      SOURCE = fetchurl {
        url = "https://github.com/martinvonz/jj/releases/download/v0.13.0/jj-v0.13.0-x86_64-apple-darwin.tar.gz";
        sha256 = "sha256-oRuBsFV80ameQk152zcEAmvrYyB4CJdIBb55AJE85Ao";
      };
    };
  };
}
