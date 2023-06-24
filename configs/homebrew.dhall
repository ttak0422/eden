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

let develop =
      [ "flutter"
      , "processing"
      , "tableplus"
      , "visual-studio-code"
      , "jetbrains-toolbox"
      ]

in  { taps =
      [ "homebrew/cask"
      , "homebrew/cask-fonts"
      , "homebrew/core"
      , "koekeishiya/formulae"
      ]
    , brews = [ "lunchy", "qemu" ]
    , casks =
          [ "aquaskk"
          , "cyberduck"
          , "displaylink"
          , "karabiner-elements"
          , "keycastr"
          , "onedrive"
          ]
        # fonts
        # browser
        # term
        # develop
    }
