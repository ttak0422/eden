-- [nfnl] Compiled from nvim/fnl/dap-go.fnl by https://github.com/Olical/nfnl, do not edit.
local dap_go = require("dap-go")
local dap_configurations = {{type = "go", name = "Attach remote", mode = "remote", request = "attach"}}
local delve = {initialize_timeout_sec = 20, port = "${port}"}
return dap_go.setup({dap_configurations = dap_configurations, delve = delve})
