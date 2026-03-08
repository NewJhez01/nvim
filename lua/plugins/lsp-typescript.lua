return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      require("config.lsp").ensure_server_installed(opts, "vtsls")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.vtsls = {}
    end,
  },
}
