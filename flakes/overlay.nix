{ inputs, lib, ... }: {
  flake.overlays = {
    fromInputs = lib.composeManyExtensions [
      inputs.neovim-nightly-overlay.overlay
      inputs.vim-plugins-overlay.overlay
      inputs.nix-filter.overlays.default
      (final: prev:
        let inherit (prev.stdenv) mkDerivation;
        in {
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
          sonicCustomTemplates = mkDerivation {
            name = "sonic-custom-templates";
            src = ./../snippets/sonic;
            installPhase = ''
              mkdir $out
              cp -r ./* $out
            '';
          };
        })
    ];
  };
}
