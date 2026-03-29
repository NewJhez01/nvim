local group = vim.api.nvim_create_augroup("UserStartup", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd.Ex()
    end
  end,
})

local autoread_group = vim.api.nvim_create_augroup("UserAutoRead", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = autoread_group,
  pattern = "*",
  command = "checktime",
})
