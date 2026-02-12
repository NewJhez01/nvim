return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Debug continue/start",
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
        "<leader>dx",
        function()
          require("dap").terminate()
        end,
        desc = "Debug terminate",
      },
    },
    config = function()
      local dap = require("dap")

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
