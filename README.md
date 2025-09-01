# 💤 LazyVim Neovim Configuration

A modern, feature-rich Neovim configuration built on top of [LazyVim](https://github.com/LazyVim/LazyVim) with additional customizations for an enhanced development experience.

## ✨ Features

### 🎯 Core Features
- **Modern Plugin Management**: Built on [lazy.nvim](https://github.com/folke/lazy.nvim) for fast startup times
- **IDE-like Experience**: LSP, autocompletion, syntax highlighting, and more
- **Beautiful UI**: Clean interface with Tokyo Night colorscheme
- **Git Integration**: Advanced git workflows and conflict resolution
- **Fuzzy Finding**: Powerful telescope-based file and content search
- **Auto-formatting**: Consistent code formatting with language-specific tools

### 🔧 Language Support
This configuration includes comprehensive support for:
- **TypeScript/JavaScript**: Full LSP support, syntax highlighting, and tooling
- **Docker**: Dockerfile syntax and Docker Compose support
- **JSON/YAML**: Schema validation and intelligent editing
- **SQL**: Syntax highlighting and query tools
- **Markdown**: Enhanced editing with live preview capabilities
- **Tailwind CSS**: Intelligent autocomplete and class utilities
- **Git**: Advanced git integration and conflict resolution
- **Dotfiles**: Configuration file support

### 🚀 Enhanced Productivity Tools
- **Harpoon2**: Quick file navigation and project jumping
- **Refactoring Tools**: Advanced code refactoring capabilities
- **Mini Patterns**: Enhanced text patterns and highlighting
- **Auto-save**: Automatic file saving on text changes
- **Multi-cursor**: Advanced multi-cursor editing support

## 📦 Custom Plugins

### Auto-save
Automatically saves files when you stop typing or leave insert mode.
- **Plugin**: [auto-save.nvim](https://github.com/okuuva/auto-save.nvim)
- **Triggers**: `InsertLeave`, `TextChanged`
- **Command**: `:ASToggle` to toggle auto-save

### Multi-cursor Support
Advanced multi-cursor editing similar to VS Code.
- **Plugin**: [multicursor.nvim](https://github.com/jake-stewart/multicursor.nvim)
- **Key Features**: Line-based cursors, word matching, mouse support

### Tokyo Night Theme
Beautiful dark theme with multiple style variants.
- **Plugin**: [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- **Style**: Night variant for optimal contrast

## ⚡ Key Mappings

### Multi-cursor Operations
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>j` | Normal/Visual | Add cursor below |
| `<leader>k` | Normal/Visual | Add cursor above |
| `<leader>J` | Normal/Visual | Skip cursor below |
| `<leader>K` | Normal/Visual | Skip cursor above |
| `<leader>n` | Normal/Visual | Add next match |
| `<leader>N` | Normal/Visual | Add previous match |
| `<leader>s` | Normal/Visual | Skip next match |
| `<leader>S` | Normal/Visual | Skip previous match |
| `<Ctrl-Click>` | Normal | Add/remove cursor |
| `<Ctrl-q>` | Normal/Visual | Toggle cursor |
| `<Esc>` | Normal | Clear all cursors |

### Multi-cursor Layer (Active when multiple cursors exist)
| Key | Mode | Description |
|-----|------|-------------|
| `<Left>` | Normal/Visual | Previous cursor |
| `<Right>` | Normal/Visual | Next cursor |
| `<leader>x` | Normal/Visual | Delete cursor |

### Default LazyVim Keymaps
This configuration inherits all default LazyVim keymaps. Key highlights include:
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>e` - Toggle file explorer
- `<leader>gg` - LazyGit
- `<leader>xx` - Trouble diagnostics
- `<leader>cs` - LSP symbol search

For a complete list of keymaps, see the [LazyVim keymaps documentation](https://lazyvim.github.io/keymaps).

## 🛠️ Installation

### Prerequisites
- **Neovim** >= 0.9.0
- **Git** >= 2.19.0
- **Node.js** >= 16.0.0 (for LSP servers)
- **Python** >= 3.8 (for Python tooling)
- A [Nerd Font](https://www.nerdfonts.com/) for icons (recommended: JetBrains Mono Nerd Font)

### Setup Instructions

1. **Backup your existing Neovim configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   mv ~/.local/state/nvim ~/.local/state/nvim.backup
   mv ~/.cache/nvim ~/.cache/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/nvim-config.git ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Wait for initial setup**: LazyVim will automatically:
   - Install lazy.nvim plugin manager
   - Download and install all configured plugins
   - Set up LSP servers through Mason
   - Configure all language tools

5. **Restart Neovim** for the best experience after initial setup.

### Post-Installation

After installation, you may want to:
- Run `:checkhealth` to verify everything is working correctly
- Install additional LSP servers with `:Mason`
- Customize keymaps in `lua/config/keymaps.lua`
- Add personal options in `lua/config/options.lua`

## 🎨 Customization

### Adding Plugins
Create new plugin files in `lua/plugins/` directory:

```lua
-- lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  opts = {
    -- plugin configuration
  },
}
```

### Modifying Existing Plugins
Override plugin configurations by creating files in `lua/plugins/`:

```lua
-- lua/plugins/override-example.lua
return {
  "existing/plugin",
  opts = {
    -- your custom options
  },
}
```

### Custom Keymaps
Add personal keymaps in `lua/config/keymaps.lua`:

```lua
local map = vim.keymap.set

map("n", "<leader>my", function()
  -- your custom function
end, { desc = "My custom keymap" })
```

### Language Servers
Add or configure LSP servers in Mason or through plugin configurations.

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin version lock file
├── lazyvim.json            # LazyVim extras configuration
├── stylua.toml             # Lua formatting configuration
├── lua/
│   ├── config/
│   │   ├── autocmds.lua    # Auto commands
│   │   ├── keymaps.lua     # Key mappings
│   │   ├── lazy.lua        # Lazy.nvim setup
│   │   └── options.lua     # Neovim options
│   └── plugins/
│       ├── autosave.lua    # Auto-save configuration
│       ├── colorscheme.lua # Theme configuration
│       ├── multicursor.lua # Multi-cursor setup
│       └── example.lua     # Example plugin configurations
```

## 🔧 LazyVim Extras Included

This configuration includes the following LazyVim extras:
- `lazyvim.plugins.extras.editor.harpoon2` - Quick file navigation
- `lazyvim.plugins.extras.editor.refactoring` - Code refactoring tools
- `lazyvim.plugins.extras.lang.docker` - Docker support
- `lazyvim.plugins.extras.lang.git` - Enhanced git integration
- `lazyvim.plugins.extras.lang.json` - JSON schema support
- `lazyvim.plugins.extras.lang.markdown` - Markdown editing tools
- `lazyvim.plugins.extras.lang.sql` - SQL language support
- `lazyvim.plugins.extras.lang.tailwind` - Tailwind CSS utilities
- `lazyvim.plugins.extras.lang.typescript` - TypeScript/JavaScript support
- `lazyvim.plugins.extras.lang.yaml` - YAML language support
- `lazyvim.plugins.extras.util.dot` - Dotfile support
- `lazyvim.plugins.extras.util.mini-hipatterns` - Enhanced text patterns

## 🐛 Troubleshooting

### Common Issues

**Plugins not loading**: 
- Run `:Lazy sync` to update plugins
- Check `:Lazy` for any plugin errors

**LSP not working**:
- Run `:Mason` to install language servers
- Check `:LspInfo` for server status
- Verify Node.js and Python are installed

**Performance issues**:
- Check startup time with `nvim --startuptime startup.log`
- Disable unused plugins in the configuration

**Formatting not working**:
- Ensure formatters are installed via Mason
- Check `:ConformInfo` for formatter status

### Getting Help
- Check [LazyVim documentation](https://lazyvim.github.io/)
- Run `:checkhealth` for system diagnostics
- Search existing issues on plugin repositories
- Create an issue in this repository for configuration-specific problems

## 📚 Learning Resources

- [LazyVim Documentation](https://lazyvim.github.io/)
- [Neovim User Manual](https://neovim.io/doc/user/)
- [Lua Guide for Neovim](https://github.com/nanotee/nvim-lua-guide)
- [LazyVim Keymaps Reference](https://lazyvim.github.io/keymaps)

## 🤝 Contributing

Feel free to submit issues and enhancement requests! This configuration is continuously evolving to provide the best development experience.

## 📄 License

This configuration is released under the same license as LazyVim. See the [LICENSE](LICENSE) file for details.

---

**Happy coding!** 🚀