(let [null (require :null-ls)
      utils (require :null-ls.utils)
      helpers (require :null-ls.helpers)
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
               ; null.builtins.diagnostics.textlint
               ;;; formatting ;;;
               {:name :dhall-format
                :filetypes [:dhall]
                :generator (null.formatter {:command :dhall
                                            :args [:format :$FILENAME]
                                            :to_stdin true})}
               {:name :fnlfmt
                :method [FORMATTING]
                :filetypes [:fennel]
                :generator (null.formatter {:command :fnlfmt
                                            :args [:$FILENAME]
                                            :to_stdin true})}]]
  (null.setup {: defaults : sources})
  nil)
