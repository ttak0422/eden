{ inputs, ... }: {
  perSystem = { system, pkgs, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        inputs.vim-plugins-overlay.overlay
        inputs.nix-filter.overlays.default
        (final: prev: {
          vimPlugins = prev.vimPlugins // {
            # ddc-sorter_itemsize = prev.vimUtils.buildVimPluginFrom2Nix {
            #   pname = "ddc-sorter_itemsize";
            #   version = "local";
            #   src = inputs.ddc-sorter_itemsize;
            # };
          };
          tmuxPlugins = prev.tmuxPlugins // {
            tmux-pomodoro-plus = prev.tmuxPlugins.mkTmuxPlugin {
              pluginName = "tmux-pomodoro-plus";
              rtpFilePath = "pomodoro.tmux";
              version = "local";
              src = inputs.tmux-pomodoro-plus;
            };
          };
          javaPackages = prev.javaPackages // { inherit (inputs) jol; };
        })
      ];
      config = { allowUnfree = true; };
    };
  };
}
