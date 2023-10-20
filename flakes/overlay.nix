{ inputs, self, system, lib, ... }: {
  flake.overlays = {
    fromInputs = lib.composeManyExtensions [
      # WIP: darwin
      # inputs.neovim-nightly-overlay.overlay
      inputs.vim-plugins-overlay.overlay
      inputs.emacs.overlay
      inputs.nix-filter.overlays.default
      (final: prev:
        let inherit (prev.stdenv) mkDerivation isDarwin;
        in {
          tmuxPlugins = prev.tmuxPlugins // {
            # tmux-pomodoro-plus = prev.tmuxPlugins.mkTmuxPlugin {
            #   pluginName = "tmux-pomodoro-plus";
            #   rtpFilePath = "pomodoro.tmux";
            #   version = "local";
            #   src = inputs.tmux-pomodoro-plus;
            # };
          };
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit (prev.stdenv) system;
            config.allowUnfree = true;
          };
          pkgs-x86_64-darwin = import inputs.nixpkgs {
            system = "x86_64-darwin";
            config.allowUnfree = true;
          };
        })
    ];
  };
}
