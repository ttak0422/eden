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

let function = ""

let darwinFunction =
      ''
      function emacsClient() {
        if [[ -n "$1" ]]; then
          emacsclient -c "$1" &
        else
          emacsclient -c &
        fi
      }
      ''

let sharedProfile =
      ''
      export NLS_LANG=Japanese_Japan.AL32UTF8
      ''

let sharedPath =
      ''
      export PATH=~/.npm-packages/bin:$PATH
      export NODE_PATH=~/.npm-packages/lib/node_modules
      ''

let darwinPath =
      ''
      export PATH=$PATH:/opt/homebrew/bin
      ''

in  { aliases =
      { `..` = "cd .."
      , g = "cd \$(ghq root)/\$(ghq list | fzf)"
      , gg = "ghq get"
      , cat = "bat"
      , ls = "exa"
      , tree = "exa -T"
      , sqlplus = "rlwrap sqlplus"
      }
    , darwinAliases.emacs = "emacsClient"
    , bindkey.emacs = "bindkey -e"
    , history
    , sharedProfile
    , sharedPath
    , darwinPath
    , function
    , darwinFunction
    }
