return {
  "okuuva/auto-save.nvim",
  version = "^1.0.0",
  opts = {
    trigger_events = {
      immediate_save = { "FocusLost", "QuitPre", "VimSuspend" },
      defer_save = { "InsertLeave", "TextChanged" },
      cancel_deferred_save = { "InsertEnter" },
    },
    condition = function(buf)
      if vim.bo[buf].filetype == "harpoon" then
        return false
      end

      if vim.bo[buf].buftype ~= "" then
        return false
      end

      return true
    end,
  },
}
