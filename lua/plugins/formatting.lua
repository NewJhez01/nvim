return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				desc = "Format file",
			},
		},
		opts = function()
			local util = require("conform.util")

			return {
				formatters = {
					mago = {
						command = util.find_executable({ "vendor/bin/mago" }, "mago"),
						args = { "format", "$FILENAME" },
						cwd = util.root_file({ "mago.toml" }),
						require_cwd = true,
						stdin = false,
					},
				},
				format_on_save = function(_)
					return {
						timeout_ms = 2000,
						lsp_format = "fallback",
					}
				end,
				formatters_by_ft = {
					lua = { "stylua" },
					php = function(bufnr)
						local name = vim.api.nvim_buf_get_name(bufnr)
						if name:match("/[Tt]ests?/") or name:match("Test%.php$") then
							return { "mago", "php_cs_fixer", stop_after_first = true }
						end
						return { "mago", "pint", "php_cs_fixer", stop_after_first = true }
					end,
					javascript = { "prettierd", "prettier", stop_after_first = true },
					javascriptreact = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
					yaml = { "prettierd", "prettier", stop_after_first = true },
					markdown = { "prettierd", "prettier", stop_after_first = true },
					go = { "gofumpt", "goimports", stop_after_first = true },
					rust = { "rustfmt" },
				},
			}
		end,
	},
}
