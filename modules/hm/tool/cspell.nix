{ inputs, ... }:
let dict = "${inputs.cspell-dicts}/dictionaries";
in {
  home = {
    file.".config/cspell/cspell.json".text = builtins.toJSON {
      allowCompoundWords = true;
      import = [
        # "${dict}/bash/cspell-ext.json"
        # "${dict}/clojure/cspell-ext.json"
        # "${dict}/cpp/cspell-ext.json"
        # "${dict}/csharp/cspell-ext.json"
        # "${dict}/css/cspell-ext.json"
        # "${dict}/dart/cspell-ext.json"
        # "${dict}/django/cspell-ext.json"
        # "${dict}/docker/cspell-ext.json"
        # "${dict}/dotnet/cspell-ext.json"
        # "${dict}/elixir/cspell-ext.json"
        # "${dict}/en_US/cspell-ext.json"
        # "${dict}/filetypes/cspell-ext.json"
        # "${dict}/fsharp/cspell-ext.json"
        # "${dict}/git/cspell-ext.json"
        # "${dict}/golang/cspell-ext.json"
        # "${dict}/haskell/cspell-ext.json"
        # "${dict}/html-symbol-entities/cspell-ext.json"
        # "${dict}/html/cspell-ext.json"
        # "${dict}/k8s/cspell-ext.json"
        # "${dict}/kotlin/cspell-ext.json"
        # "${dict}/makefile/cspell-ext.json"
        # "${dict}/markdown/cspell-ext.json"
        # "${dict}/node/cspell-ext.json"
        # "${dict}/npm/cspell-ext.json"
        # "${dict}/python/cspell-ext.json"
        # "${dict}/data-science/cspell-ext.json"
        # "${dict}/ruby/cspell-ext.json"
        # "${dict}/rust/cspell-ext.json"
        # "${dict}/scala/cspell-ext.json"
        # "${dict}/shell/cspell-ext.json"
        # "${dict}/sql/cspell-ext.json"
        # "${dict}/svelte/cspell-ext.json"
        # "${dict}/swift/cspell-ext.json"
        # "${dict}/vue/cspell-ext.json"
        "${dict}/lua/cspell-ext.json"
        "${dict}/typescript/cspell-ext.json"
        "${dict}/vim/cspell-ext.json"
        "${dict}/java/cspell-ext.json"
      ];
      dictionaries = [ "user" ];
      dictionaryDefinitions = [{
        name = "user";
        path = "~/.local/share/cspell/user.txt";
        description = "User defined words";
      }];
      languageSettings = [
        {
          languageId = "lua,fnl";
          locale = "*";
          ignoreRegExpList = [ "/require.*/" ];
          dictionaries = [ "lua" ];
        }
        {
          languageId = "vim";
          locale = "*";
          ignoreRegExpList = [ "/Plug .*/" ];
          dictionaries = [ "vim" ];
        }
      ];
      overrides = [{
        filename = "**/{*.fnl}";
        languageId = "fnl";
      }];
    };
  };
}
