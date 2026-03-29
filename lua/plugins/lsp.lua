return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = function()
      return {
        ensure_installed = require("config.lsp").mason_servers(),
        automatic_enable = false,
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lsp = require("config.lsp")

      vim.diagnostic.config({
        float = {
          border = "rounded",
          source = "if_many",
        },
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
          end

          map("n", "K", vim.lsp.buf.hover, "LSP hover")
          map("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
          map("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", "Goto definition (FZF)")
          map("n", "gr", "<cmd>FzfLua lsp_references<CR>", "Goto references (FZF)")
          map("n", "gi", vim.lsp.buf.implementation, "LSP implementation")
          map("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
          map("n", "<leader>cr", vim.lsp.buf.rename, "LSP rename")
          map({ "n", "v" }, "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", "Code actions (FZF)")

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local group = vim.api.nvim_create_augroup("UserLspDocumentHighlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              group = group,
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "LspDetach" }, {
              group = group,
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("n", "<leader>uh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), {
                bufnr = event.buf,
              })
            end, "Toggle inlay hints")
          end
        end,
      })

      for _, server in ipairs(lsp.enabled_servers()) do
        vim.lsp.config(server, {
          capabilities = lsp.capabilities(),
        })
        vim.lsp.enable(server)
      end
    end,
  },
}
