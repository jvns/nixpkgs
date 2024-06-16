{ pkgs, ... }:  
with pkgs;
stdenv.mkDerivation rec {
  pname = "dnsdist";
  version = "1.9.4";

  src = fetchurl {
    url = "https://downloads.powerdns.com/releases/dnsdist-${version}.tar.bz2";
    hash = "sha256-KX06N1GvRlBmXJ04kKHVp6BGcXXyyGB9DVmA4/1n7xQ";
  };

  patches = [
    # Disable tests requiring networking:
    # "Error connecting to new server with address 192.0.2.1:53: connecting socket to 192.0.2.1:53: Network is unreachable"
    ./disable-network-tests.patch
  ];

  nativeBuildInputs = [ pkg-config protobuf ];
  buildInputs = [ boost libedit lua zlib  openssl ];

  configureFlags = [
    "--with-protobuf=yes"
    "--disable-dependency-tracking"
    "--enable-unit-tests"
  ];

  doCheck = true;

  enableParallelBuilding = true;

  passthru.tests = {
    inherit (nixosTests) dnsdist;
  };

  meta = with lib; {
    description = "DNS Loadbalancer";
    mainProgram = "dnsdist";
    homepage = "https://dnsdist.org";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ jojosch ];
  };
}
