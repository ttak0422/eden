;; configured by bundler-nvim
(local on_attach (dofile args.on_attach_path))
(local capabilities (dofile args.capabilities_path))

(vim.diagnostic.config {:severity_sort true})
(vim.lsp.set_log_level :WARN)

(let [signs [{:name :DiagnosticSignError :text ""}
             {:name :DiagnosticSignWarn :text ""}
             {:name :DiagnosticSignInfo :text ""}
             {:name :DiagnosticSignHint :text ""}]]
  (each [_ sign (ipairs signs)]
    (vim.fn.sign_define sign.name {:texthl sign.name :text "" :numhl ""})))

(local lspconfig (require :lspconfig))
(local util (require :lspconfig.util))
(local windows (require :lspconfig.ui.windows))

(set windows.default_options.border ["┏"
                                     "━"
                                     "┓"
                                     "┃"
                                     "┛"
                                     "━"
                                     "┗"
                                     "┃"])

;; lua
(lspconfig.lua_ls.setup {: on_attach
                         : capabilities
                         :settings {:Lua {:runtime {:version :LuaJIT}
                                          :diagnostics {:globals [:vim]}}
                                    :workspace {}
                                    :telemetry {:enable false}}})

;; fennel
(lspconfig.fennel_ls.setup {: on_attach : capabilities})

;; nix
(lspconfig.nil_ls.setup {: on_attach
                         : capabilities
                         :autostart true
                         :settings {:nil {:formatting {:command [:nixpkgs-fmt]}}}})

;; bash
(lspconfig.bashls.setup {: on_attach : capabilities})

;; csharp
(lspconfig.csharp_ls.setup {: on_attach : capabilities})

;; python
(lspconfig.pyright.setup {: on_attach : capabilities})

;; ruby
(lspconfig.solargraph.setup {: on_attach : capabilities})

;; toml
(lspconfig.taplo.setup {: on_attach : capabilities})

;; go
(lspconfig.gopls.setup {: on_attach
                        : capabilities
                        :settings {:gopls {:analyses {:unusedparams true}}}
                        :staticcheck true})

;; dart
(lspconfig.dartls.setup {: on_attach : capabilities})

;; dhall
(lspconfig.dhall_lsp_server.setup {: on_attach : capabilities})

;; yaml
(lspconfig.yamlls.setup {: on_attach
                         : capabilities
                         :settings {:yaml {:keyOrdering false}}})

;; html
(lspconfig.html.setup {: on_attach : capabilities})

;; css, css, less
(lspconfig.cssls.setup {: on_attach : capabilities})

;; typescript (node)
(lspconfig.vtsls.setup {: on_attach
                        : capabilities
                        :single_file_support false
                        :root_dir (util.root_pattern :package.json)
                        :settings {:separate_diagnostic_server true
                                   :publish_diagnostic_on :insert_leave
                                   :typescript {:suggest {:completeFunctionCalls true}
                                                :preferences {:importModuleSpecifier :relative}}}
                        :vtsls {:experimental {:completion {:enableServerSideFuzzyMatch true}}}})

;; markdown
(lspconfig.marksman.setup {: on_attach : capabilities})

nil
