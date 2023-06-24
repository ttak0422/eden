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


      # = HEADER =================================================
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
      # = FOOTER (if exists) =====================================
      #
      # - BREAKING CHANGE: <breaking change summary>
      # - DEPRECATED: <what is deprecated>
      #
      # ==========================================================
      ''

in  { ignores, template }
