{
  description = "julia's dev env";
  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
      hugoFlake.url = "path:../hugo-0.40";
      paperjamFlake.url = "path:../paperjam";
      picatFlake.url = "path:../picat";
  };
  outputs = { self, nixpkgs, hugoFlake, paperjamFlake, picatFlake }: {
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
        fish
        fzf
        gawk
        ghostscript
        gnuplot
        go_1_20
        got
        graphviz
        helix
        htop
        hugoFlake.defaultPackage.aarch64-darwin
        imagemagick
        jq
        just
        keystone
        lazygit
        lftp
        librsvg
        libyaml
        #lima
        lsd
        glpk
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
        nixos-rebuild
        nmap
        nodejs
        nushell
        osxfuse
        pandoc
        paperjamFlake.defaultPackage.aarch64-darwin
        picatFlake.defaultPackage.aarch64-darwin
        pdf2svg
        pdftk
        pngquant
        poppler_utils
        pstree
        pv
        pyright
        python310Packages.black
        python310Packages.httpie
        qpdf
        rbspy
        ripgrep
        rlwrap
        ruby
        s3cmd
        scdoc
        sd
        shellcheck
        texlive.combined.scheme-basic
        tig
        tldr
        tmux
        toml2json
        tree
        trippy
        visidata
        viu
        wget
        wormhole-william
        # oil (build failure)
        # py-spy (build failure)  
        #nodejs-16_x
#       prettier # ??? just installed with npm idk
#       zulu     # maybe easier to manage this outside of nix??
        ];
        pathsToLink = [ "/share/man" "/share/doc" "/bin" "/lib" "include"];
        extraOutputsToInstall = [ "man" "doc" ];
      };
    };
  }
