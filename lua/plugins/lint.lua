return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      local js_lint_filetypes = {
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        vue = true,
      }

      local function find_up(names, startpath)
        local path = vim.fs.find(names, {
          upward = true,
          path = startpath,
        })[1]

        return path and vim.fs.dirname(path) or nil
      end

      local function buffer_start_dir(bufnr)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname == "" then
          return vim.loop.cwd()
        end

        return vim.fs.dirname(bufname)
      end

      local function php_lint_cwd(bufnr)
        local start = buffer_start_dir(bufnr)
        return find_up({ "phpcs.xml", "phpcs.xml.dist" }, start)
          or find_up({ "composer.json" }, start)
          or vim.loop.cwd()
      end

      local function js_lint_cwd(bufnr)
        local start = buffer_start_dir(bufnr)
        return find_up({
          "eslint.config.js",
          "eslint.config.cjs",
          "eslint.config.mjs",
          "eslint.config.ts",
          "eslint.config.cts",
          "eslint.config.mts",
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          ".eslintrc.json",
        }, start)
          or find_up({ "package.json" }, start)
          or vim.loop.cwd()
      end

      local function try_lint()
        local bufnr = vim.api.nvim_get_current_buf()
        local filetype = vim.bo[bufnr].filetype

        if filetype == "php" then
          lint.try_lint(nil, { cwd = php_lint_cwd(bufnr) })
          return
        end

        if js_lint_filetypes[filetype] then
          lint.try_lint(nil, { cwd = js_lint_cwd(bufnr) })
          return
        end

        lint.try_lint()
      end

      lint.linters_by_ft = {
        lua = { "luacheck" },
        php = { "phpcs" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
      }

      local group = vim.api.nvim_create_augroup("UserLint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = group,
        callback = function()
          try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>cl", function()
        try_lint()
      end, { desc = "Lint file" })
    end,
  },
}
