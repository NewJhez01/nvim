local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local mason_servers = {
  "gopls",
  "intelephense",
  "lua_ls",
  "rust_analyzer",
  "tailwindcss",
  "vtsls",
  "vue_ls",
}
local enabled_servers = {
  "gopls",
  "intelephense",
  "lua_ls",
  "rust_analyzer",
  "tailwindcss",
  "vtsls",
  "vue_ls",
}

function M.capabilities()
  return capabilities
end

function M.mason_servers()
  return mason_servers
end

function M.enabled_servers()
  return enabled_servers
end

function M.ensure_server_installed(opts, server)
  opts.ensure_installed = opts.ensure_installed or {}
  if not vim.tbl_contains(opts.ensure_installed, server) then
    table.insert(opts.ensure_installed, server)
  end
end

return M
