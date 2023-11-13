{
  description = "A flake for paperjam with libpaper as a dependency";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2305.492172.tar.gz";

  outputs = { self, nixpkgs }: {
    defaultPackage.aarch64-darwin = with nixpkgs.legacyPackages.aarch64-darwin; stdenv.mkDerivation rec {
      pname = "paperjam";
      version = "1.2";
      
      src = fetchurl {
        url = "https://mj.ucw.cz/download/linux/${pname}-${version}.tar.gz";
        sha256 = "sha256-0AziT7ROICTEPKaA4Ub1B8NtIfLmxRXriW7coRxDpQ0";
      };

      libpaper = stdenv.mkDerivation rec {
        pname = "libpaper";
        version = "0.1";

        src = fetchFromGitHub {
          owner = "naota";
          repo = "libpaper";
          rev = "51ca11ec543f2828672d15e4e77b92619b497ccd";
          sha256 = "sha256-PXcZaEjVVhRK6V+keQcJRtfvwBRY3y2C9RQiMgjWSGo";
        };
      };

      buildInputs = [ libiconv qpdf asciidoc libpaper ];

      installFlags = [ "PREFIX=$(out)" ];

      meta = with nixpkgs.legacyPackages.aarch64-darwin.lib; {
        description = "Paperjam - a tool for [purpose], with libpaper as dependency";
        homepage = "https://mj.ucw.cz/sw/paperjam/";
        platforms = platforms.unix;
        license = with licenses; [ bsd3 gpl2 ];
      };
    };
  };
}
