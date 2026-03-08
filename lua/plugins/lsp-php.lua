return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      require("config.lsp").ensure_server_installed(opts, "intelephense")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.intelephense = {
        init_options = {
          licenceKey = os.getenv("INTELEPHENSE_LICENSE"),
        },
        settings = {
          intelephense = {
            environment = { phpVersion = "8.2" },
            files = { maxSize = 5000000 },
          },
        },
      }
    end,
  },
}
