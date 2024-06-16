{ pkgs, ... }:  
with pkgs;
stdenv.mkDerivation (finalAttrs: {
  pname = "pdns";
  version = "4.9.1";

  src = fetchurl {
    url = "https://downloads.powerdns.com/releases/pdns-${finalAttrs.version}.tar.bz2";
    hash = "sha256-MNlnG48IR3Tby6IPWlOjE00IIqsu3D75aNoDDmMN0Jo=";
  };
  # redact configure flags from version output to reduce closure size
  patches = [ ./version.patch ];

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    boost
    lua
    sqlite
    protobuf
    yaml-cpp
    libsodium
    curl
    openssl
  ];

  # Configure phase requires 64-bit time_t even on 32-bit platforms.
  env.NIX_CFLAGS_COMPILE = toString (lib.optionals stdenv.hostPlatform.is32bit [
    "-D_TIME_BITS=64"
    "-D_FILE_OFFSET_BITS=64"
  ]);

  configureFlags = [
    "--disable-silent-rules"
    "--enable-dns-over-tls"
    "--enable-unit-tests"
    "--enable-reproducible"
    "--enable-tools"
    "--enable-ixfrdist"
    "--with-libsodium"
    "--with-sqlite3"
    "--with-libcrypto=${openssl.dev}"
    "sysconfdir=/etc/pdns"
  ];

  # nix destroy with-modules arguments, when using configureFlags
  preConfigure = ''
    configureFlagsArray+=(
      "--with-modules="
      "--with-dynmodules=bind gsqlite3 lua2 pipe remote"
    )
  '';

  # We want the various utilities to look for the powerdns config in
  # /etc/pdns, but to actually install the sample config file in
  # $out
  installFlags = [ "sysconfdir=$(out)/etc/pdns" ];

  enableParallelBuilding = true;
  doCheck = true;

  #passthru.tests = {
  #  nixos = nixosTests.powerdns;
  #};

  meta = with lib; {
    description = "Authoritative DNS server";
    homepage = "https://www.powerdns.com";
    platforms = platforms.unix;
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ mic92 disassembler nickcao ];
  };
})
