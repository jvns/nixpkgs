{
  description = "A flake for picat";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";

  outputs = { self, nixpkgs }: {
    defaultPackage.aarch64-darwin = with nixpkgs.legacyPackages.aarch64-darwin; 
    let
      ARCH = {
        i686-linux    = "linux32";
        x86_64-linux  = "linux64";
        aarch64-linux = "linux64";
        aarch64-darwin =  "mac64";
      }."${stdenv.hostPlatform.system}" or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
    in
    stdenv.mkDerivation rec {
      pname = "picat";
      version = "3.3p3";

      src = fetchurl {
        url = "http://picat-lang.org/download/picat333_src.tar.gz";
        hash = "sha256-LMmAHCGKgon/wNbrXTUH9hiHyGVwwSDpB1236xawzXs=";
      };

      buildInputs = [ zlib ];

      inherit ARCH;

      hardeningDisable = [ "format" ];
      enableParallelBuilding = true;

      buildPhase = "cd emu && make -j $NIX_BUILD_CORES -f Makefile.$ARCH";
      installPhase = "mkdir -p $out/bin && cp picat $out/bin/picat";

      meta = with lib; {
        description = "Logic-based programming langage";
        homepage    = "http://picat-lang.org/";
        license     = licenses.mpl20;
        platforms   = platforms.unix;
        maintainers = with maintainers; [ earldouglas thoughtpolice ];
      };
    };
  };
}
