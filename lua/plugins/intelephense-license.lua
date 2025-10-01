return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          -- NOTE: British spelling!
          init_options = {
            licenceKey = os.getenv("INTELEPHENSE_LICENSE"),
          },
          -- optional, tweak as you like
          settings = {
            intelephense = {
              environment = { phpVersion = "8.2" },
              files = { maxSize = 5000000 },
            },
          },
        },
      },
    },
  },
}
