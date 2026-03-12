local active_colorscheme = "tokyonight"

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
      if active_colorscheme == "tokyonight" then
        vim.cmd.colorscheme("tokyonight")
      end
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    priority = 1000,
    opts = {
      transparent = true,
      on_highlights = function(hl, c)
        hl.Normal = { bg = "NONE" }
        hl.NormalNC = { bg = "NONE" }
        hl.NormalFloat = { bg = "NONE" }
        hl.FloatBorder = { bg = "NONE" }
        hl.FloatTitle = { bg = "NONE" }
        hl.SignColumn = { bg = "NONE" }
        hl.EndOfBuffer = { bg = "NONE" }
        hl.LineNr = { fg = "#c0caf5" }
        hl.CursorLineNr = { fg = c.yellow, bold = true }
        hl.LineNrAbove = { fg = c.blue }
        hl.LineNrBelow = { fg = c.blue }
      end,
    },
    config = function(_, opts)
      require("cyberdream").setup(opts)
      if active_colorscheme == "cyberdream" then
        vim.cmd.colorscheme("cyberdream")
      end
    end,
  },
}
