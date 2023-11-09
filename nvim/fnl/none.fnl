(let [null (require :null-ls)
      utils (require :null-ls.utils)
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
      sources [; null.builtins.diagnostics.textlint
               ]]
  (null.setup {: defaults : sources})
  nil)
