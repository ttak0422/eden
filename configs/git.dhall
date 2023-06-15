let ignores =
      [ "*~"
      , ".DS_Store"
      , "Thumbs.db"
      , "Thumbs.db:encryptable"
      , ".idea"
      , ".vscode/*"
      , "!.vscode/settings.json"
      , "!.vscode/tasks.json"
      , "!.vscode/launch.json"
      , "!.vscode/extensions.json"
      , "*.code-workspace"
      , ".ionide"
      , ".vs"
      , ".env"
      , ".settings"
      , ".vimrc.lua"
      ]

let template =
      ''


      # ==========================================================
      #
      # build: ---------------- changes that affect artifacts
      # feat: ----------------- add new feature
      # chore: ---------------- maintenance
      # fix: ------------------ bug fix
      # refactor: ------------- refactor
      # test: ----------------- test
      # style: ---------------- formatting
      # docs: ----------------- documents
      # perf: ----------------- improve performance
      # ci: ------------------- ci
      #
      # <type>(<scope>): <short summary>
      #   │       │             │
      #   │       │             └─> Summary in present tense.
      #   │       │                 Not capitalized.
      #   │       │                 No period at the end.
      #   │       │
      #   │       └─> Commit Scope: common|core|logic|...
      #   │
      #   └─> Commit Type: build|feat|chore|...
      #
      # ==========================================================
      ''

in  { ignores, template }
