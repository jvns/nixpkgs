with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "quarto";
  version = "1.2.335";
  src = fetchurl {
    url = "https://github.com/quarto-dev/quarto-cli/releases/download/v${version}/quarto-${version}-macos.tar.gz";
    sha256 = "sha256-k5SA89WqSkqv1Mwu50kfAIaDAEZFr13csCqeTsO5nEc";
  };

  sourceRoot=".";

  nativeBuildInputs = [
    makeWrapper
  ];

  patches = [
    ./fix-deno-path.patch
  ];

  postPatch = ''
    # Compat for Deno >=1.26
    substituteInPlace bin/quarto.js \
      --replace 'Deno.setRaw(stdin.rid, ' 'Deno.stdin.setRaw(' \
      --replace 'Deno.setRaw(Deno.stdin.rid, ' 'Deno.stdin.setRaw('
  '';

  dontStrip = true;

  preFixup = ''
    wrapProgram $out/bin/quarto \
      --prefix PATH : ${lib.makeBinPath [ deno ]} \
      --prefix QUARTO_PANDOC : ${pkgs.pandoc}/bin/pandoc \
      --prefix QUARTO_ESBUILD : ${pkgs.esbuild}/bin/esbuild \
      --prefix QUARTO_DART_SASS : ${pkgs.nodePackages.sass}/bin/sass \
      --prefix QUARTO_PYTHON : ${python3.withPackages (ps: with ps; [ jupyter ipython ])}/bin/python3
  '';

  installPhase = ''
      runHook preInstall

      mkdir -p $out/bin $out/share

      rm -r bin/tools

      mv bin/* $out/bin
      mv share/* $out/share

      runHook preInstall
  '';

  meta = with lib; {
    description = "Open-source scientific and technical publishing system built on Pandoc";
    longDescription = ''
        Quarto is an open-source scientific and technical publishing system built on Pandoc.
        Quarto documents are authored using markdown, an easy to write plain text format.
    '';
    homepage = "https://quarto.org/";
    changelog = "https://github.com/quarto-dev/quarto-cli/releases/tag/v${version}";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ mrtarantoga ];
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode binaryBytecode ];
  };
}
