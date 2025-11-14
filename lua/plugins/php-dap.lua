return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
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
