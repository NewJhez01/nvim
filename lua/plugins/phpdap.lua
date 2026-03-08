return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    keys = {
      {
        "<leader>dc",
        function()
          local dap = require("dap")
          if dap.session() then
            dap.continue()
            return
          end

          local ok, fzf = pcall(require, "fzf-lua")
          if ok then
            fzf.dap_configurations()
            return
          end

          dap.continue()
        end,
        desc = "Debug continue/start (FZF config picker)",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug toggle breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Debug conditional breakpoint",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Debug step into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Debug step over",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Debug step out",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Debug REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Debug run last",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Debug UI",
      },
      {
        "<leader>dv",
        function()
          local dapui = require("dapui")
          dapui.open({})
          dapui.float_element("scopes", { enter = true })
        end,
        desc = "Debug values (scopes)",
      },
      {
        "<leader>dx",
        function()
          require("dap").terminate()
        end,
        desc = "Debug terminate",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup({})

      dap.listeners.before.attach.dapui_config = function()
        dapui.open({})
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close({})
      end

      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { vim.fn.expand("~/.local/share/nvim/vscode-php-debug/out/phpDebug.js") },
      }

      dap.configurations.php = {
        {
          name = "Listen for Xdebug (Docker)",
          type = "php",
          request = "launch",
          port = 9003,
          stopOnEntry = false,
          log = true,

          pathMappings = {
            ["/vagrant/sterbegeldversicherung"] = "/Users/owen.harper-jones/Projects/sterbegeldversicherung",
          },
        },
        {
          name = "Listen for Xdebug (CLI)",
          type = "php",
          request = "launch",
          port = 9003,
          stopOnEntry = false,
          log = true,
          pathMappings = {
            ["/vagrant/sterbegeldversicherung"] = "/Users/owen.harper-jones/Projects/sterbegeldversicherung",
          },
        },
      }
    end,
  },
}
