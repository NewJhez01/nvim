local group = vim.api.nvim_create_augroup("UserStartup", { clear = true })

-- Open netrw on startup when no file/dir was passed on the CLI.
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd.Ex()
    end
  end,
})
