# PHP Debugging with nvim-dap and Docker

A comprehensive guide for setting up PHP debugging with nvim-dap for Dockerized PHP projects using Xdebug.

## Prerequisites

- Neovim with `nvim-dap` plugin installed
- Node.js installed on your host machine
- Docker container running PHP with Xdebug enabled
- Basic familiarity with nvim-dap

## 1. Install vscode-php-debug

The PHP debug adapter runs on your host machine and communicates between nvim-dap and Xdebug:

# Create directory for the debug adapter
mkdir -p ~/.local/share/nvim/vscode-php-debug

# Clone and build vscode-php-debug
cd ~/.local/share/nvim
git clone https://github.com/xdebug/vscode-php-debug.git
cd vscode-php-debug
npm install
npm run build**Verify installation:**
ls ~/.local/share/nvim/vscode-php-debug/out/phpDebug.jsThe `phpDebug.js` file should exist.

## 2. Configure nvim-dap

Add this configuration to your nvim-dap setup (typically in your Neovim config):

return {
  {
    "mfussenegger/nvim-dap",
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
          
          -- Map Docker paths to local paths
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        },
      }
    end,
  },
}### Understanding Path Mappings

The `pathMappings` configuration is critical for debugging Docker containers:

- **Docker path (key)**: Where the code lives inside your container (e.g., `/var/www/html`, `/app`, `/code`)
- **Local path (value)**: Your local workspace directory

When Xdebug reports a file path from inside Docker, nvim-dap uses this mapping to locate the corresponding file on your machine.

**Example configurations:**

-- If code is mounted at /var/www/html in container
pathMappings = {
  ["/var/www/html"] = "/home/user/projects/myapp",
}

-- If code is mounted at /app in container
pathMappings = {
  ["/app"] = "/Users/username/workspace/myproject",
}

-- Multiple mappings (if needed)
pathMappings = {
  ["/var/www/html"] = "/home/user/projects/myapp",
  ["/vendor"] = "/home/user/projects/myapp/vendor",
}**To find your Docker path:**
docker exec -it <container-name> pwd## 3. Verify Xdebug in Docker

### Check Xdebug is installed

docker exec -it <container-name> php -vLook for: `with Xdebug v3.x.x`

### Check Xdebug configuration

docker exec -it <container-name> php -i | grep xdebug.clientRequired settings in your php.ini or xdebug.ini:

xdebug.mode=debug
xdebug.start_with_request=trigger
xdebug.client_host=host.docker.internal
xdebug.client_port=9003
xdebug.log=/tmp/xdebug.log**Notes:**
- `host.docker.internal` works on Docker Desktop (Mac/Windows)
- On Linux, use your host IP address (find with: `ip addr show docker0 | grep inet`)
- Port 9003 is the default for Xdebug 3.x (2.x used 9000)

## 4. How Debugging Works

### The Connection Flow

1. **nvim-dap acts as SERVER** - Listens on port 9003 waiting for connections
2. **Xdebug acts as CLIENT** - Connects to port 9003 when triggered
3. **Debug adapter translates** - Converts between DAP protocol and Xdebug protocol

### Important: Start Order Matters!

**✅ Correct order:**
1. Start nvim-dap listener first (`:DapContinue`)
2. Then trigger PHP code with Xdebug

**❌ Wrong order:**
1. Trigger PHP code first
2. Start nvim-dap listener (too late - Xdebug already tried and failed)

## 5. Usage

### Basic Debugging Workflow

1. **Open the PHP file** you want to debug in Neovim

2. **Set breakpoints** at lines where you want execution to pause:
   :lua require('dap').toggle_breakpoint()
      Or use your keybinding (commonly `<leader>b`)

3. **Start the debugger listener** (MUST be done before triggering PHP):
   :DapContinue
      Or press `<F5>` if configured

   You should see DAP UI open or a status message.

4. **Trigger your PHP code with Xdebug**:

   **For CLI scripts:**
   docker exec -it <container-name> bash -c "XDEBUG_TRIGGER=1 php /path/to/script.php"
      **For console commands:**
   docker exec -it <container-name> bash -c "XDEBUG_TRIGGER=1 php bin/console your:command"
      **For PHPUnit tests:**
   docker exec -it <container-name> bash -c "XDEBUG_TRIGGER=1 vendor/bin/phpunit tests/YourTest.php"
      **For web requests:**
   - Add `?XDEBUG_TRIGGER=1` to your URL
   - Or use a browser extension (e.g., "Xdebug Helper" for Chrome/Firefox)

5. **Nvim stops at breakpoints** and you can inspect variables, step through code, etc.

### Debugger Commands

**Vim commands:**
- `:DapContinue` - Start/continue debugging
- `:DapStepOver` - Execute current line, don't enter functions
- `:DapStepInto` - Step into function calls
- `:DapStepOut` - Step out of current function
- `:DapToggleBreakpoint` - Toggle breakpoint on current line
- `:DapTerminate` - Stop debugging session

**Default keybindings (if configured):**
- `<F5>` - Continue
- `<F10>` - Step over
- `<F11>` - Step into
- `<F12>` - Step out
- `<leader>b` - Toggle breakpoint

## 6. Troubleshooting

### "Could not connect to debugging client" Error

**Symptom:** Xdebug reports connection failure

**Cause:** nvim-dap listener wasn't started before PHP execution

**Solution:** 
1. Start `:DapContinue` first
2. Then trigger PHP code

### Breakpoints Not Hit

**Possible causes:**

1. **Wrong path mappings**
   - Check Docker path: `docker exec -it <container> pwd`
   - Verify local path matches your workspace
   - Ensure paths in `pathMappings` are correct

2. **Code not executing**
   - Verify the file actually runs
   - Check you're setting breakpoints in executed code

3. **Xdebug not triggered**
   - Ensure `XDEBUG_TRIGGER=1` is set
   - For web: check browser extension is enabled

### Verify nvim-dap is Listening

Check if port 9003 is in use:

# macOS/Linux
lsof -i :9003

# Should show node process listening### Check Xdebug Logs

View Xdebug connection attempts:

docker exec -it <container-name> tail -f /tmp/xdebug.logLook for connection attempts and errors.

### Enable DAP Debug Logging

In Neovim:

:lua require('dap').set_log_level('TRACE')
:lua vim.cmd('e ' .. vim.fn.stdpath('cache') .. '/dap.log')Review the log for connection issues.

### Test Xdebug Configuration

Quick test to verify Xdebug works:

docker exec -it <container-name> bash -c "XDEBUG_TRIGGER=1 php -r 'echo \"test\n\";'"If nvim-dap is listening, this should trigger a connection.

## 7. Advanced Configuration

### Conditional Breakpoints

Set breakpoints that only trigger when a condition is true:

:lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))Example conditions: `$id === 123`, `count($items) > 10`

### Log Points

Log messages without stopping execution:

:lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log message: '))### Multiple Configurations

Add different configurations for various scenarios:

dap.configurations.php = {
  {
    name = "Listen for Xdebug (Docker)",
    type = "php",
    request = "launch",
    port = 9003,
    pathMappings = {
      ["/var/www/html"] = "${workspaceFolder}",
    },
  },
  {
    name = "Listen for Xdebug (Local)",
    type = "php",
    request = "launch",
    port = 9003,
    -- No path mappings needed for local PHP
  },
}Select configuration when starting: `:DapContinue` will show a picker.

## 8. Common Use Cases

### Debug a Specific Test

# Start listener in nvim first (:DapContinue)
# Then run specific test
docker exec -it <container> bash -c "XDEBUG_TRIGGER=1 vendor/bin/phpunit --filter testMethodName"### Debug Web Application

1. Set breakpoints in controller/route handler
2. Start `:DapContinue` in nvim
3. Visit URL with `?XDEBUG_TRIGGER=1` parameter
4. Or enable browser extension and click to trigger

### Debug Background Jobs/Workers

# Start listener first
docker exec -it <container> bash -c "XDEBUG_TRIGGER=1 php artisan queue:work"## 9. Tips & Best Practices

- **Leave listener running**: You can keep `:DapContinue` active while working and trigger PHP multiple times
- **Set breakpoints anytime**: Before or after starting the listener - both work
- **Use DAP UI**: Install `nvim-dap-ui` for visual variable inspection and call stacks
- **Check call stack**: When stopped at breakpoint, use DAP UI to see how you got there
- **Watch expressions**: Evaluate PHP expressions while debugging
- **Remote debugging**: This setup works for remote Docker containers too (adjust `xdebug.client_host`)

## Quick Reference

# Install debug adapter (one-time setup)
mkdir -p ~/.local/share/nvim/vscode-php-debug
cd ~/.local/share/nvim
git clone https://github.com/xdebug/vscode-php-debug.git
cd vscode-php-debug
npm install && npm run build

# Verify Xdebug in container
docker exec -it <container> php -v | grep -i xdebug

# Debug workflow
# 1. In nvim: :DapContinue
# 2. In terminal:
docker exec -it <container> bash -c "XDEBUG_TRIGGER=1 php your-script.php"

# Check if listening
lsof -i :9003

# View Xdebug logs
docker exec -it <container> tail -f /tmp/xdebug.log## Resources

- [nvim-dap documentation](https://github.com/mfussenegger/nvim-dap)
- [Xdebug documentation](https://xdebug.org/docs/)
- [vscode-php-debug](https://github.com/xdebug/vscode-php-debug)
- [DAP protocol specification](https://microsoft.github.io/debug-adapter-protocol/)
