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
      ensure_installed = { "gopls", "rust_analyzer", "intelephense", "vtsls", "lua_ls" },
      automatic_enable = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
      })

      vim.lsp.config("gopls", {
        capabilities = capabilities,
      })

      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
      })

      vim.lsp.config("vtsls", {
        capabilities = capabilities,
      })

      vim.lsp.config("intelephense", {
        capabilities = capabilities,
        init_options = {
          licenceKey = os.getenv("INTELEPHENSE_LICENSE"),
        },
        settings = {
          intelephense = {
            environment = { phpVersion = "8.2" },
            files = { maxSize = 5000000 },
          },
        },
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })

      vim.lsp.enable("gopls")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.enable("vtsls")
      vim.lsp.enable("intelephense")
      vim.lsp.enable("lua_ls")
    end,
  },
}
