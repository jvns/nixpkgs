with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "paperjam";
  version = "1.2";

  src = fetchurl {
    url = "https://mj.ucw.cz/download/linux/${pname}-${version}.tar.gz";
    sha256 = "sha256:d00ce24fb44e2024c43ca680e146f507c36d21f2e6c515eb896edca11c43a50d";
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
