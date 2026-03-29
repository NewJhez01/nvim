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
        "gotmpl",
        "rust",
        "php",
        "typescript",
        "tsx",
        "javascript",
        "json",
        "yaml",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, 0, args.match)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
