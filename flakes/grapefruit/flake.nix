{
  description = "julia's dev env";
  inputs = {
      # copy from https://github.com/NixOS/nixpkgs/commits/nixpkgs-23.11-darwin/
      nixpkgs.url = "github:NixOS/nixpkgs/700804df18b73e2fe360d950f371aaec1691dea2";
      #nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
      # copy from https://github.com/NixOS/nixpkgs/commits/nixpkgs-unstable/
      nixpkgsUnstable.url = "github:NixOS/nixpkgs/98b00b6947a9214381112bdb6f89c25498db4959";
      hugoFlake.url = "path:../hugo-0.40";
      paperjamFlake.url = "path:../paperjam";
      picatFlake.url = "path:../picat";
      powerdnsFlake.url = "path:../powerdns";
  };
  outputs = { self, nixpkgs, hugoFlake, paperjamFlake, picatFlake, powerdnsFlake, nixpkgsUnstable }: {
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
        # emscripten
        esbuild
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
        # install jj from unstable
        nixpkgsUnstable.legacyPackages.aarch64-darwin.jujutsu
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
        libgit2
        lychee # link checker
        meld
        micro
        moreutils
        mtr
        nb
        #ncdu
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
        #powerdnsFlake.defaultPackage.aarch64-darwin
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
        # texlive.combined.scheme-basic
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
