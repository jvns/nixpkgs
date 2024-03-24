{ pkgs, ... }:  
with pkgs;
stdenv.mkDerivation rec {
  pname = "picat";
  version = "3.3p3";

  src = fetchurl {
    url = "http://picat-lang.org/download/picat333_src.tar.gz";
    hash = "sha256-LMmAHCGKgon/wNbrXTUH9hiHyGVwwSDpB1236xawzXs=";
  };

  buildInputs = [ zlib ];

  #inherit ARCH;

  hardeningDisable = [ "format" ];
  enableParallelBuilding = true;

  buildPhase = "cd emu && make -j $NIX_BUILD_CORES -f Makefile.mac64";
  installPhase = "mkdir -p $out/bin && cp picat $out/bin/picat";

  meta = with lib; {
    description = "Logic-based programming langage";
    homepage    = "http://picat-lang.org/";
    license     = licenses.mpl20;
    platforms   = platforms.unix;
    maintainers = with maintainers; [ earldouglas thoughtpolice ];
  };
}
