{ pkgs, username, userEmail, ... }:
let prefs = pkgs.dhallToNix (builtins.readFile ./../../../configs/git.dhall);
in {
  programs.git = {
    inherit userEmail;
    inherit (prefs) ignores;

    enable = true;
    userName = username;
    lfs.enable = true;
    delta.enable = true;
    aliases = {
      tags = "tag";
      ignore = "!f() { curl -L -s https://www.gitignore.io/api/$@ ;}; f";
      get-default-branch =
        "!f() { git symbolic-ref refs/remotes/origin/HEAD | awk -F'[/]' '{print $NF}'; }; f";
      get-pr-hash =
        "!f() { git log --merges --oneline --reverse --ancestry-path $1...$(git get-default-branch) | grep 'Merge pull request #' | head -n 1; }; f";
      # e.g. git delete-merged-branch develop
      # 参考 (https://qiita.com/hajimeni/items/73d2155fc59e152630c4)
      delete-merged-branch =
        "!f() { git checkout $1; git branch --merged | egrep -v '\\*|develop|master|main'|xargs git branch -d; }; f";
      openpr =
        "!f() { gh browse -- $(git get-pr-hash $1 | cut -f5 -d ' ' | sed -e 's%#%%'); }; f";
    };
    extraConfig = {
      core = {
        autocrlf = false;
        editor = "nvim";
        # fsmonitor = true;
        ignorecase = false;
        untrackedcache = true;
      };
      color = { ui = "auto"; };
      commit.template = "~/.committemplate";
      init.defaultBranch = "main";
    };
  };
  home = {
    packages = with pkgs; [ ghq pre-commit gh ];
    file.".committemplate".text = prefs.template;
  };
}
