return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site",
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "go",
        "rust",
        "php",
        "typescript",
        "tsx",
        "javascript",
        "json",
        "yaml",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      local ts = require("nvim-treesitter")

      ts.setup({
        install_dir = opts.install_dir,
      })

      if opts.auto_install and opts.ensure_installed and #opts.ensure_installed > 0 then
        ts.install(opts.ensure_installed)
      end

      local group = vim.api.nvim_create_augroup("UserTreesitterSetup", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if not vim.tbl_contains(opts.ensure_installed, ft) then
            return
          end

          pcall(vim.treesitter.start, args.buf)
          if opts.indent and opts.indent.enable then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
