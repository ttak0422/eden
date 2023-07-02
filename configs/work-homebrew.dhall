let fonts =
      [ "font-fira-code"
      , "font-hack-nerd-font"
      , "font-hackgen-nerd"
      , "font-jetbrains-mono-nerd-font"
      , "font-plemol-jp"
      , "font-plemol-jp-nf"
      , "font-plemol-jp-hs"
      , "font-roboto"
      , "font-roboto-mono"
      , "font-roboto-mono-nerd-font"
      ]

let browser = [ "firefox", "google-chrome" ]

let term = [ "kitty" ]

let develop = [ "tableplus", "visual-studio-code", "jetbrains-toolbox" ]

in  { taps =
      [ "homebrew/cask"
      , "homebrew/cask-fonts"
      , "homebrew/core"
      , "koekeishiya/formulae"
      ]
    , brews = [ "lunchy" ]
    , casks =
          [ "alfred"
          , "aquaskk"
          , "displaylink"
          , "karabiner-elements"
          , "neovide"
          ]
        # fonts
        # browser
        # term
        # develop
    }
