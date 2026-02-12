return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {},
      automatic_enable = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    opts = {
      servers = {},
    },
    config = function(_, opts)
      local lsp = require("config.lsp")

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
      })

      for server, server_opts in pairs(opts.servers or {}) do
        local merged = vim.tbl_deep_extend("force", {
          capabilities = lsp.capabilities(),
        }, server_opts or {})

        vim.lsp.config(server, merged)
        vim.lsp.enable(server)
      end
    end,
  },
}
