{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-tool = { pkgs, ... }: {
    home.packages = with pkgs; [
      bat # ------------ cat clone
      bottom # --------- system monitor
      commitizen # ----- git commit helper
      coreutils-full # - cat, ls, mv, wget, ...
      exa # ------------ ls clone
      fd # ------------- find clone
      figlet # --------- ascii
      gnugrep
      gnused
      graphviz # ------- dot
      hey # ------------ load test tool
      htop # ----------- top clone
      jq # ------------- JSON processor
      lazygit # -------- git tui
      neofetch # ------- system information tool
      nix-prefetch-git
      nix-prefetch-github
      peco
      pkg-config # ----- compile helper
      plantuml # ------- uml
      pwgen # ---------- password generator
      ranger # --------- cui filer
      ripgrep # -------- grep clone
      sd # ------------- sed clone
      sqlite # --------- db engine
      taskwarrior
      taskwarrior-tui
      tealdeer # ------- tldr: complete `man` command
      timewarrior
      tokei # ---------- code count
      viddy # ---------- watch
      wget # ----------- GNU Wget
      yq # ------------- YAML/XML/TOML processor
      zoxide # --------- fast cd
    ];
    imports = [ ./direnv.nix ./fzf.nix ./pet.nix ];
  };
}
