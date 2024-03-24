{ pkgs, ... }:  
with pkgs;
stdenv.mkDerivation rec {
  pname = "paperjam";
  version = "1.2";

  src = fetchurl {
    url = "https://mj.ucw.cz/download/linux/${pname}-${version}.tar.gz";
    sha256 = "sha256-0AziT7ROICTEPKaA4Ub1B8NtIfLmxRXriW7coRxDpQ0";
  };

  installFlags = [ "PREFIX=$(out)" ];
  buildInputs = [ libiconv qpdf libpaper asciidoc ];

  meta = with lib; {
    homepage = "https://mj.ucw.cz/sw/paperjam/";
    description = "Paperjam";
    platforms = platforms.unix;
    license = with licenses; [ bsd3 gpl2 ];
  };
}
