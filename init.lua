vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.filetype.add({
  pattern = {
    [".*%.tmpl$"] = "gotmpl",
    ["go%.work$"] = "gowork",
  },
})

require("config.options")
require("config.lazy")
require("config.keymaps")
pcall(require, "config.autocmds")
