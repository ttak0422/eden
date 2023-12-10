{ inputs, ... }:
let dict = "${inputs.cspell-dicts}/dictionaries";
in {
  home = {
    file.".config/cspell/cspell.json".text = builtins.toJSON {
      allowCompoundWords = true;
      dictionaries = [ "lua" "vim" ];
      dictionaryDefinitions = [
        {
          name = "lua";
          path = "${dict}/lua/dict/lua.txt";
          description = "Lua programming language dictionary";
        }
        {
          name = "vim";
          path = "${dict}/vim/dict/vim.txt";
          description = "Vim programming language dictionary";
        }
      ];
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
