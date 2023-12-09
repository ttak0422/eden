let settings =
      ''
      set -g default-terminal 'xterm-256color'
      set -ga terminal-overrides ',$TERM:Tc'
      set -g base-index 1
      set -g renumber-windows on
      set -g status-keys vi
      set -g mode-keys vi
      set -s escape-time 1
      set -s set-clipboard on
      set -g mouse on
      set -g bell-action none
      ''

let windowSettings =
      ''
      setw -g pane-base-index 1
      setw -g clock-mode-style  12
      ''

let bindings =
      ''
      # basic
      bind d detach-client
      bind : command-prompt
      # copy
      bind [ copy-mode
      # paste
      bind ] paste-buffer
      # clock
      bind t clock-mode
      # zoom
      bind z resize-pane -Z \; set -g status \; set -g pane-border-status

      # prefix c-b → c-s
      unbind C-b
      set -g prefix C-s

      # session: create and fill empty title
      bind C-n command-prompt -I "" "new -s '%%'"\; select-pane -T ""
      # session: choose
      bind s choose-session
      # session: rename
      bind S command-prompt -I "#S" "rename-session '%%'"

      # window: create and fill empty title
      bind c new-window\; select-pane -T ""
      # window: close
      bind X confirm-before -p "kill-window #W? (y/n)" kill-window
      # window: choose
      bind w choose-window
      # window: rename
      bind W command-prompt -I "#W" "rename-window '%%'"
      # window: move
      bind 1 select-window -t :1
      bind 2 select-window -t :2
      bind 3 select-window -t :3
      bind 4 select-window -t :4
      bind 5 select-window -t :5
      bind 6 select-window -t :6
      bind 7 select-window -t :7
      bind 8 select-window -t :8
      bind 9 select-window -t :9
      bind 0 select-window -t :10
      bind -r , previous-window
      bind -r . next-window

      # pane: split and fill empty title
      bind | split-window -h -c '#{pane_current_path}'\; select-pane -T ""
      bind - split-window -v -c '#{pane_current_path}'\; select-pane -T ""
      # pane: close
      bind x confirm-before -p "kill-pane #T? (y/n)" kill-pane
      # pane: rename
      bind P command-prompt -I "" "select-pane -T '%%'"
      # pane: move
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R
      # pane: resize
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      ''

let plugins =
      ''
      # session: resurrect
      set -g @resurrect-strategy-nvim 'session'
      # session: continuum
      set -g @continuum-boot 'on'
      set -g @continuum-boot-options 'alacritty'
      set -g @continuum-save-interval '5' # minutes
      set -g @continuum-restore 'on'
      ''

let overrides =
      ''
      set -as terminal-overrides ',*:sitm=\E[3m' # Italics support for older ncurses
      set -as terminal-overrides ',*:smxx=\E[9m' # Strikeout
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours
      ''

in  { config =
        ''
          ${overrides}
          ${settings}
          ${windowSettings}
          ${bindings}
          ${plugins}
        ''
    }
