{ pkgs, username, userEmail, ... }:
let prefs = pkgs.dhallToNix (builtins.readFile ./git.dhall);
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
      # e.g. git delete-merged-branch develop
      # 参考 (https://qiita.com/hajimeni/items/73d2155fc59e152630c4)
      delete-merged-branch = ''
        !f () { git checkout $1; git branch --merged|egrep -v \
        '\\*|develop|main'|xargs git branch -d; };f
      '';
    };
    extraConfig = {
      core = {
        autocrlf = false;
        editor = "nvim";
      };
      color = { ui = "auto"; };
      commit.template = "~/.committemplate";
      init.defaultBranch = "main";
    };
  };
  home = {
    packages = with pkgs; [ ghq ];
    file.".committemplate".text = prefs.template;
  };
}
