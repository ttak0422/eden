(let [dap-go (require :dap-go)
      dap_configurations [{:type :go
                           :name "Attach remote"
                           :mode :remote
                           :request :attach}]
      delve {:initialize_timeout_sec 20 :port "${port}"}]
  ;; go
  (dap-go.setup {: dap_configurations : delve}))
