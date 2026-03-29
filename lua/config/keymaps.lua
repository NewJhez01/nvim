local map = vim.keymap.set

-- Window navigation and splits
map("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
map("n", "<leader>wj", "<C-w>j", { desc = "Window down" })
map("n", "<leader>wk", "<C-w>k", { desc = "Window up" })
map("n", "<leader>wl", "<C-w>l", { desc = "Window right" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window" })
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit Neovim" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove highlight from search" })

map("n", "<leader>vv", vim.cmd.Ex, { desc = "Open netrw" })

-- fzf-lua
map("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>gh", "<cmd>FzfLua git_bcommits<CR>", { desc = "Git history (current file)" })
map("n", "<leader>gH", function()
	local line = vim.api.nvim_win_get_cursor(0)[1]
	require("fzf-lua").git_bcommits({
		cmd = string.format(
			[[git log --color --pretty=format:"%%C(yellow)%%h%%Creset %%Cgreen(%%><(12)%%cr%%><|(12))%%Creset %%s %%C(blue)<%%an>%%Creset" -L %d,%d:{file} --no-patch]],
			line,
			line
		),
		preview = "git show --color {1}",
	})
end, { desc = "Git history (current line)" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Delete buffer (force)" })

-- Markdown
map("n", "<leader>m", function()
	require("render-markdown").toggle()
end, { desc = "Toggle Markdown render" })
