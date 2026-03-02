local map = vim.keymap.set

-- Window navigation and splits
map("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
map("n", "<leader>wj", "<C-w>j", { desc = "Window down" })
map("n", "<leader>wk", "<C-w>k", { desc = "Window up" })
map("n", "<leader>wl", "<C-w>l", { desc = "Window right" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window" })

map("n", "<leader>vv", vim.cmd.Ex, { desc = "Open netrw" })

-- fzf-lua
map("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>gh", "<cmd>FzfLua git_bcommits<CR>", { desc = "Git history (current file)" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Delete buffer (force)" })

-- LSP
map("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Goto definition (FZF)" })
map("n", "gr", "<cmd>FzfLua lsp_references<CR>", { desc = "Goto references (FZF)" })
map("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "Code actions (FZF)" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP rename" })
