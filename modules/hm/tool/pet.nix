{ pkgs, lib, ... }:
let
  inherit (lib.strings) concatStringsSep concatMapStringsSep;
  makeSnippet = { description, command, tag ? [ ], output ? "" }: ''
    [[snippets]]
        description = "${description}"
        command = "${command}"
        tag = [${concatStringsSep ", " (map (x: ''"${x}"'') tag)}]
        output = "${output}"
  '';
  snippets = concatMapStringsSep "\n" makeSnippet [
    {
      description = "ping";
      command = "ping 8.8.8.8";
      tag = [ "network" "google" ];
      output = "sample snippet";
    }
    {
      description = "create local server";
      command = "python -m http.server <port=8080>";
      tag = [ "python" "server" ];
      output = "simple server";
    }
    {
      description = "filter & map";
      command = "find . -name '<RegExp=*.ext>' | xargs <Fn=foo>";
    }
    {
      description = "prefetch git";
      tag = [ "nix" ];
      command = "nix-prefetch-git --url '<Repository>'";
    }
    {
      description = "rust repl";
      tag = [ "rust" ];
      command = "evcxr";
    }
    {
      description = "python setup";
      tag = [ "python" ];
      command = "python3 -m venv .venv";
    }
    {
      description = "direnv python";
      tag = [ "python" "direnv" ];
      command = "echo 'source .venv/bin/activate' >> .envrc";
    }
    {
      description = "derivate regex pattern from example";
      tag = [ "regex" ];
      command = "grex -c '<example>'";
    }
  ];
in {
  home = {
    packages = [ pkgs.pet ];
    file.".config/pet/config.toml".text = ''
      [General]
          snippetfile = "$HOME/.config/pet/snippets.toml"
          editor = "nvim"
          column = 40
          selectcmd = "fzf"
    '';
    file.".config/pet/snippets.toml".text = snippets;
  };
}
