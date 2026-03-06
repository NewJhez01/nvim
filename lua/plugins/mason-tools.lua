return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "stylua",
        "luacheck",
        "phpcs",
        "php-cs-fixer",
        "pint",
        "prettierd",
        "prettier",
        "eslint_d",
        "gofumpt",
        "goimports",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 24,
    },
  },
}
