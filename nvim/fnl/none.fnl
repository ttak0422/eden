(let [null (require :null-ls)
      utils (require :null-ls.utils)
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
      fnlfmt {:name :fnlfmt
              :method [FORMATTING]
              :filetypes [:fennel]
              :generator (null.formatter {:command :fnlfmt
                                          :args [:$FILENAME]
                                          :to_stdin true})}
      sources [;;; code actions ;;;
               ;;; completion ;;;
               ;;; diagnostics ;;;
               (null.builtins.diagnostics.eslint.with {:prefer_local :node_modules/.bin})
               ; null.builtins.diagnostics.textlint
               ;;; formatting ;;;
               fnlfmt]]
  (null.setup {: defaults : sources})
  nil)
