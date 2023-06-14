let history =
      let ramHistSize = 100000

      let fileHistSize = 1000000

      in  ''
          HISTSIZE=${Natural/show ramHistSize}
          SAVEHIST=${Natural/show fileHistSize}
          setopt SHARE_HISTORY
          setopt HIST_REDUCE_BLANKS
          setopt HIST_IGNORE_DUPS
          setopt HIST_IGNORE_SPACE
          setopt EXTENDED_HISTORY
          setopt HIST_EXPIRE_DUPS_FIRST
          ''

let sharedPath = "\n"

let darwinPath =
      ''
      export PATH=/opt/homebrew/bin:$PATH
      ''

in  { aliases =
      { `..` = "cd .."
      , g = "cd \$(ghq root)/\$(ghq list | fzf)"
      , gg = "ghq get"
      , cat = "bat"
      , ls = "exa"
      , tree = "exa -T"
      }
    , bindkey.emacs = "bindkey -e"
    , history
    , sharedPath
    , darwinPath
    }
