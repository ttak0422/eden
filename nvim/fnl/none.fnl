(fn is_active_lsp [lsp_name]
  (let [bufnr (vim.api.nvim_get_current_buf)
        clients (vim.lsp.buf_get_clients bufnr)]
    (accumulate [acc false _ client (ipairs clients)]
      (or acc (= lsp_name client.name)))))

(let [null (require :null-ls)
      utils (require :null-ls.utils)
      helpers (require :null-ls.helpers)
      formatter_factory (require :null-ls.helpers.formatter_factory)
      methods (require :null-ls.methods)
      FORMATTING methods.internal.FORMATTING
      defaults {:border nil
                :cmd [:nvim]
                :debounce 250
                :debug false
                :default_timeout 5000
                :diagnostic_config {}
                :diagnostics_format "#{m}"
                :fallback_severity vim.diagnostic.severity.ERROR
                :log_level :warn
                :notify_format "[null-ls] %s"
                :on_attach nil
                :on_init nil
                :on_exit nil
                :root_dir (utils.root_pattern [:.null-ls-root :.git])
                :should_attach nil
                :sources nil
                :temp_dir nil
                :update_in_insert false}
      dhall-format {:name :dhall-format
                    :method [FORMATTING]
                    :filetypes [:dhall]
                    :generator (null.formatter {:command :dhall
                                                :args [:format :$FILENAME]
                                                :to_stdin true})}
      fnlfmt {:name :fnlfmt
              :method [FORMATTING]
              :filetypes [:fennel]
              :generator (null.formatter {:command :fnlfmt
                                          :args [:$FILENAME]
                                          :to_stdin true})}
      sources [;;; code actions ;;;
               ;;; completion ;;;
               ;;; diagnostics ;;;
               (null.builtins.diagnostics.eslint.with {:prefer_local :node_modules/.bin
                                                       :condition (fn [utils]
                                                                    (utils.root_has_file [;; https://eslint.org/docs/latest/user-guide/configuring/configuration-files-new
                                                                                          :eslint.config.js
                                                                                          ;; https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
                                                                                          :.eslintrc
                                                                                          :.eslintrc.js
                                                                                          :.eslintrc.cjs
                                                                                          :.eslintrc.yaml
                                                                                          :.eslintrc.yml
                                                                                          :.eslintrc.json]))})
               (null.builtins.diagnostics.cspell.with {:diagnostics_postprocess (fn [diagnostic]
                                                                                  (set diagnostic.severity
                                                                                       (. vim.diagnostic.severity
                                                                                          :WARN)))
                                                       :condition (fn []
                                                                    (> (vim.fn.executable :cspell)
                                                                       0))})
               ; null.builtins.diagnostics.textlint
               ;;; formatting ;;;
               null.builtins.formatting.tidy
               null.builtins.formatting.fixjson
               null.builtins.formatting.taplo
               null.builtins.formatting.shfmt
               null.builtins.formatting.stylua
               null.builtins.formatting.yapf
               null.builtins.formatting.google_java_format
               null.builtins.formatting.nixfmt
               null.builtins.formatting.dart_format
               null.builtins.formatting.gofmt
               null.builtins.formatting.rustfmt
               null.builtins.formatting.yamlfmt
               (null.builtins.formatting.prettier.with {:prefer_local :node_modules/.bin
                                                        :runtime_condition (fn [...]
                                                                             (is_active_lsp :vtsls))})
               (null.builtins.formatting.deno_fmt.with {:runtime_condition (fn [...]
                                                                             (is_active_lsp :denols))})
               dhall-format
               fnlfmt]]
  (null.setup {: defaults : sources})
  (vim.api.nvim_create_user_command :Format "lua vim.lsp.buf.format()" {})
  nil)
