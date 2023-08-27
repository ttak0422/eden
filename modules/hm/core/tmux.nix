# WIP ....
{ pkgs, lib, ... }:
let
  inherit (builtins) mapAttrs;
  inherit (pkgs) writeScriptBin;
  inherit (lib) mapAttrsToList;

  prefs = pkgs.dhallToNix (builtins.readFile ./../../../configs/tmux.dhall);

  activeSimbol = "";
  zoomOutSimbol = "";
  zoomInSimbol = "";
  darkBgColor = "#3F464B";
  darkFgColor = "DarkGrey";
  darkFgColor2 = "White";
  lightFgColor = "#2A2F33";
  leftStatusColor = "#61AFEF";

  scripts = let
    shebang = ''
      #!${pkgs.bash}/bin/bash
    '';
    scriptDefinitions = {
      TMUX_SESSION_NAME = ''
        DEFAULT="DEFAULT"
        NAME=$(tmux display-message -p "#S")
        if [ $NAME == "0" ]; then echo $DEFAULT; else echo $NAME; fi
      '';
      TMUX_PANE_NAME = ''
        NAME=$(tmux display-message -p "#T")
        if [ -z $NAME ]; then echo $(tmux display-message -p "#{pane_current_path}"); else echo $NAME; fi
      '';
      TMUX_USER = ''
        echo " $USER"
      '';
      TMUX_LOA = ''
        uptime | awk -F "[:,]"  '{printf "%s %s %s\n",$(NF - 2),$(NF - 1), $NF}'
      '';
      TMUX_SINGLE_PANE = ''
        num=`tmux list-panes | wc -l`;
        if [[ 1 = $num ]]; then
          echo 0;
        else
          echo 1;
        fi
      '';
    };
  in mapAttrs (k: v: writeScriptBin k (shebang + v)) scriptDefinitions;
  scriptPackages = mapAttrsToList (k: v: v) scripts;

  # plugins for tmux
  tmuxPlugins = with pkgs.tmuxPlugins; [
    resurrect
    continuum
    better-mouse-mode
    copycat
    urlview
  ];

  zoom = "#{?window_zoomed_flag,${zoomInSimbol},${zoomOutSimbol}}";
  active = " #{?client_prefix,${activeSimbol},}";

  statusline = ''
    # pomodoro
    set -g @pomodoro_start 'p'
    set -g @pomodoro_on "#[fg=$text_red] "
    set -g @pomodoro_complete "#[fg=$text_green] "
    set -g @pomodoro_granularity 'on'
    set -g status-interval 1
    set -g @pomodoro_notifications 'on'
    set -g @pomodoro_sound 'on'

    set -g status on
    set -g status-position bottom
    set -g status-left-length 40
    set -g status-right-length 80
    set-option -g status-left "#[bg=${leftStatusColor},fg=${lightFgColor},bold] #(${scripts.TMUX_SESSION_NAME}/bin/TMUX_SESSION_NAME) "

    set-option -g status-justify "centre"
    set-window-option -g window-status-format "#[fg=${darkFgColor}] #I:#W #[default]"
    set-window-option -g window-status-current-format "#[fg=${darkFgColor2},bold] #I:#W #[default]"

    set -g status-right "#(${scripts.TMUX_USER}/bin/TMUX_USER) "

    set -g status-bg '${darkBgColor}'
    set -g status-fg '${darkFgColor}'
  '';

  paneborder = ''
    set -g pane-active-border-style ""
    set -g pane-border-style ""
    set -g pane-border-format "#{?pane_active, ${zoom} #(${scripts.TMUX_PANE_NAME}/bin/TMUX_PANE_NAME)${active},}"
    set -g pane-border-status top
  '';

  extraConfig = ''
    ${statusline}
    ${paneborder}
    ${prefs.config}
  '';
in {
  home.packages = scriptPackages;
  programs.tmux = {
    inherit extraConfig;
    enable = true;
    plugins = tmuxPlugins;
    sensibleOnTop = true;
    shortcut = "b";
    keyMode = "vi";
    customPaneNavigationAndResize = false;
    newSession = true;
    escapeTime = 1;
    baseIndex = 1;
    historyLimit = 10000;
  };
}
