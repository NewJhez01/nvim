local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

function M.capabilities()
  return capabilities
end

function M.ensure_server_installed(opts, server)
  opts.ensure_installed = opts.ensure_installed or {}
  if not vim.tbl_contains(opts.ensure_installed, server) then
    table.insert(opts.ensure_installed, server)
  end
end

return M
