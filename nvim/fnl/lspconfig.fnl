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
(local climb (require :climbdir))
(local marker (require :climbdir.marker))

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
                        :settings {:separate_diagnostic_server true
                                   :publish_diagnostic_on :insert_leave
                                   :typescript {:suggest {:completeFunctionCalls true}
                                                :preferences {:importModuleSpecifier :relative}}}
                        :root_dir (fn [path]
                                    (climb.climb path
                                           (marker.one_of (marker.has_readable_file :package.json)
                                                          (marker.has_directory :node_modules))
                                           {:halt (marker.one_of (marker.has_readable_file :deno.json))}))
                        :vtsls {:experimental {:completion {:enableServerSideFuzzyMatch true}}}})

;; typescript (deno)
(lspconfig.denols.setup {: on_attach
                         : capabilities
                         :single_file_support false
                         :root_dir (fn [path]
                                     (local found
                                            (climb.climb path
                                                   (marker.one_of (marker.has_readable_file :deno.json)
                                                                  (marker.has_readable_file :deno.jsonc)
                                                                  (marker.has_directory :denops))
                                                   {:halt (marker.one_of (marker.has_readable_file :package.json)
                                                                         (marker.has_directory :node_modules))}))
                                     (local buf (. vim.b (vim.fn.bufnr)))
                                     (when found
                                       (set buf.deno_deps_candidate
                                            (.. found :/deps.ts)))
                                     found)
                         :init_options {:lint true
                                        :unstable false
                                        :suggest {:completeFunctionCalls true
                                                  :names true
                                                  :paths true
                                                  :autoImports true
                                                  :imports {:autoDiscover true
                                                            :hosts (vim.empty_dict)}}}
                         :settings {:deno {:enable true}}})

;; markdown
(lspconfig.marksman.setup {: on_attach : capabilities})

nil
