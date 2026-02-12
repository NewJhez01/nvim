return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night",
      on_highlights = function(hl, c)
        hl.LineNr = { fg = "#c0caf5" }
        hl.CursorLineNr = { fg = c.yellow, bold = true }
        hl.LineNrAbove = { fg = c.blue }
        hl.LineNrBelow = { fg = c.blue }
        hl.SignColumn = { bg = "NONE" }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
