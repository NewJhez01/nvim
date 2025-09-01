-- Make line numbers pop with tokyonight-night
return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      on_highlights = function(hl, c)
        hl.LineNr = { fg = "#c0caf5" } -- brighter gutter numbers
        hl.CursorLineNr = { fg = c.yellow, bold = true }
        hl.LineNrAbove = { fg = c.blue } -- relative numbers above
        hl.LineNrBelow = { fg = c.blue } -- relative numbers below
        hl.SignColumn = { bg = "NONE" } -- keep gutter clean
      end,
    },
  },
}
