{ inputs, ... }: {
  imports = [ inputs.bundler.flakeModules.vim ];
  perSystem = { system, config, pkgs, lib, ... }: {
    # _module.args.pkgs = import inputs.nixpkgs {
    #   inherit system;
    #   overlays = import ./overlays.nix inputs;
    # };

    bundler-vim = {
      default = {
        eagerPlugins = with pkgs.vimPlugins; [ vim-nix iceberg-vim
        ];
        lazyPlugins = with pkgs.vimPlugins; [

        vim-startuptime
        ];
        extraConfig = ''
          set cmdheight=3
        '';
      };
    };
  };
}
