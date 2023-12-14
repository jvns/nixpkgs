{
  description = "julia's dev env";
  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
      hugoFlake.url = "path:../hugo-0.40";
      paperjamFlake.url = "path:../paperjam";
  };
  outputs = { self, nixpkgs, hugoFlake, paperjamFlake }: {
    defaultPackage.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.buildEnv {
      name = "julia-dev";
      paths = with nixpkgs.legacyPackages.aarch64-darwin; [
        alacritty
        asdf-vm
        bind
        bitwise
        bottom
        broot
        cheat
        cmake
        coreutils
        cowsay
        delta
        delve
        deno
        difftastic
        direnv
        entr
        eza
        fd
        ffmpeg
        findutils
        fish
        fzf
        gawk
        ghostscript
        gnuplot
        go_1_19
        got
        graphviz
        helix
        htop
        imagemagick
        jq
        just
        keystone
        lazygit
        lftp
        librsvg
        libyaml
        lima
        lsd
        lua
        lychee # link checker
        meld
        micro
        moreutils
        mtr
        nb
        ncdu
        neovim
        ngrok
        ninja
        nmap
        #nodejs-16_x
        nodejs
        nushell
        # oil (build failure)
        osxfuse
        pandoc
        pdf2svg
        pdftk
        pngquant
        poppler_utils
        pstree
        pv
        # py-spy (build failure)  
        pyright
        python310Packages.black
        python310Packages.httpie
        qpdf
        rbspy
        ripgrep
        rlwrap
        ruby
        s3cmd
        sd
        shellcheck
        texlive.combined.scheme-basic
        tig
        tldr
        fish
        toml2json
        tree
        visidata
        viu
        wget
        wormhole-william
        hugoFlake.defaultPackage.aarch64-darwin
        paperjamFlake.defaultPackage.aarch64-darwin
#       zulu     # maybe easier to manage this outside of nix??
#       prettier # ??? just installed with npm idk
        ];
        pathsToLink = [ "/share/man" "/share/doc" "/bin" "/lib" "include"];
        extraOutputsToInstall = [ "man" "doc" ];
      };
    };
  }
