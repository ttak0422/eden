local map = vim.keymap.set
-- require hover, lsp-inlayhints, actions-preview
return function(client, bufnr)
  local function desc(d)
    return { noremap = true, silent = true, buffer = bufnr, desc = d }
  end

  -- jump
  map("n", "gd", vim.lsp.buf.definition, desc("go to definition"))
  map("n", "gsd", "<cmd>split<bar>lua vim.lsp.buf.definition()<cr>", desc("go to definition (split)"))
  map("n", "gvd", "<cmd>vsplit<bar>lua vim.lsp.buf.definition()<cr>", desc("go to definition (vsplit)"))
  map("n", "gi", vim.lsp.buf.implementation, desc("go to impl"))
  map("n", "gsi", "<cmd>split<bar>lua vim.lsp.buf.implementation<cr>", desc("go to impl (split)"))
  map("n", "gvi", "<cmd>vsplit<bar>lua vim.lsp.buf.implementation<cr>", desc("go to impl (vsplit)"))
  map("n", "gr", vim.lsp.buf.references, desc("go to references"))
  map("n", "gsr", "<cmd>split<bar>lua vim.lsp.buf.references<cr>", desc("go to references (split)"))
  map("n", "gvr", "<cmd>vsplit<bar>lua vim.lsp.buf.references<cr>", desc("go to references (vsplit)"))
  map("n", "gD", "<cmd>Glance definitions<cr>", desc("go to definition"))
  map("n", "gI", "<cmd>Glance implementations<cr>", desc("go to impl"))
  map("n", "gR", "<cmd>Glance references<cr>", desc("go to references"))

  -- action
  map("n", "K", vim.lsp.buf.hover, desc("show doc"))
  -- map("n", "K", require("hover").hover, desc("show doc"))
  -- map("n", "K", require("pretty_hover").hover, desc("show doc"))
  map("n", "<leader>K", vim.lsp.buf.signature_help, desc("show signature"))
  map("n", "<leader>D", vim.lsp.buf.type_definition, desc("show type"))
  map("n", "<leader>rn", vim.lsp.buf.rename, desc("rename"))
  map("n", "<leader>ca", require("actions-preview").code_actions, desc("code action"))
  map("n", "<leader>cc", "<cmd>Neogen class<cr>", desc("class comment"))
  map(
    "n",
    "<leader>cj",
    "<cmd>lua require('treesj').toggle({ split = { recursive = true } })<cr>",
    desc("toggle split/join rec")
  )
  map("n", "<leader>cf", "<cmd>Neogen func<cr>", desc("fn comment"))
  if client.supports_method("textDocument/formatting") then
    map("n", "<leader>cF", "<cmd>Format<cr>", desc("format"))
  end

  map({ "n", "i", "s" }, "<C-f>", function()
    if not require("noice.lsp").scroll(4) then
      return "<C-f>"
    end
  end, { silent = true, bufnr = bufnr, expr = true })

  map({ "n", "i", "s" }, "<C-b>", function()
    if not require("noice.lsp").scroll(-4) then
      return "<C-b>"
    end
  end, { silent = true, bufnr, expr = true })

  -- info
  if client.supports_method("textDocument/inlayHint") then
    require("lsp-inlayhints").on_attach(client, bufnr, false)
  end
  if client.supports_method("textDocument/publishDiagnostics") then
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      -- delay update diagnostics
      vim.lsp.diagnostic.on_publish_diagnostics,
      { update_in_insert = false }
    )
  end
end
