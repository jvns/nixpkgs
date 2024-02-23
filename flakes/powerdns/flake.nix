{
  description = "powerdns";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";

  outputs = { self, nixpkgs }: {
    defaultPackage.aarch64-darwin = with nixpkgs.legacyPackages.aarch64-darwin; stdenv.mkDerivation rec {
      pname = "powerdns";
      version = "4.8.4";
      

      src = fetchurl {
        url = "https://downloads.powerdns.com/releases/pdns-${version}.tar.bz2";
        hash = "sha256-f0DIy8RlDQb+Sau6eZAuurs4Q2Pau9XO8nGWSgfDZFw=";
      };

      buildInputs = [
        boost
        pkg-config
        sqlite
        protobuf
        yaml-cpp
        libsodium
        curl
        lua
        luajit
        openssl
      ];

      configureFlags = [
        "--with-sqlite3"
        ];
      # nix destroy with-modules arguments, when using configureFlags
      preConfigure = ''
        export PKG_CONFIG_PATH=${luajit}/lib/pkgconfig:${lua}/lib/pkgconfig
        echo $PKG_CONFIG_PATH
        configureFlagsArray+=(
          "--with-modules=gsqlite3"
        )
      '';


      installFlags = [ "sysconfdir=$(out)/etc/pdns" ];
      meta = with nixpkgs.legacyPackages.aarch64-darwin.lib; {
        description = "Authoritative DNS server";
        homepage = "https://www.powerdns.com";
        platforms = platforms.unix;
        license = licenses.gpl2;
      };
    };
  };
}
