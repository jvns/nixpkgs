with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "libpaper";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "naota";
    repo = "libpaper";
    rev = "51ca11ec543f2828672d15e4e77b92619b497ccd";
    hash = "sha256-PXcZaEjVVhRK6V+keQcJRtfvwBRY3y2C9RQiMgjWSGo";
  };

  buildInputs = [ ];

  meta = with lib; {
    homepage = "https://github.com/naota/libpaper";
    description = "libpaper";
    platforms = platforms.unix;
    license = with licenses; [ bsd3 gpl2 ];
  };
}
