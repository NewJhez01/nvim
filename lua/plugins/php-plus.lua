return {
  {
    "ccaglak/phptools.nvim",
    keys = {
      { "<leader>nn", "<cmd>PhpTools Namespace<CR>", desc = "PHP: add namespace" },
      { "<leader>nc", "<cmd>PhpTools Create<CR>", desc = "Generate PHP Actions" },
      { "<leader>ng", "<cmd>PhpTools GetSet<CR>", desc = "PHP: generate getter/setter" },
      { "<leader>nm", "<cmd>PhpTools Method<CR>", desc = "PHP: generate undefined method" },
    },
    opts = {
      ui = { enable = true }, -- keep default UI
    },
    dependencies = {
      -- treesitter is required for PHP/JSON parsing
      -- (make sure you've run :TSInstall php json once)
    },
  },
}
