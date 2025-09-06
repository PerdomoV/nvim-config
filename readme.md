# Neovim Configuration

A modern, efficient Neovim configuration optimized for TypeScript/JavaScript, PHP development with enhanced LSP support, fuzzy finding, and project navigation.

## ✨ Features

- 🚀 **Fast startup** with lazy plugin loading
- 🔍 **Fuzzy finding** with Telescope
- 📁 **Quick file navigation** with Harpoon
- 🧠 **Intelligent code completion** with nvim-cmp
- 🔧 **LSP integration** for TypeScript, JavaScript, and PHP
- 🎨 **Beautiful UI** with Tokyo Night theme and transparency
- 🌈 **Color preview** for CSS/HTML
- ⚡ **Enhanced diagnostics** with inline error display
- 🎯 **Smart keybindings** for efficient workflow

## 🛠️ Prerequisites

### Required Dependencies
```bash
# Language servers
npm install -g typescript-language-server typescript
npm install -g intelephense

# Search tools (for Telescope)
# macOS
brew install ripgrep fd

# Ubuntu/Debian
sudo apt install ripgrep fd-find

# Arch Linux
sudo pacman -S ripgrep fd
```

### Optional Dependencies
```bash
# For better icons (optional)
# Install a Nerd Font: https://www.nerdfonts.com/
```

## 📋 Complete Keybindings Reference

### Global Keybindings

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<Space>` | - | Leader key | Sets space as the leader key for all custom commands |
| `<leader>cd` | Normal | `:Ex` | Opens Netrw file explorer (Vim's built-in file manager) |

### 🔍 Telescope (Fuzzy Finding)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>ff` | Normal | `find_files` | **Find Files**: Search and open files in current directory |
| `<leader>fg` | Normal | `live_grep` | **Live Grep**: Search text content across all files (requires ripgrep) |
| `<leader>fb` | Normal | `buffers` | **Buffers**: List and switch between open buffers |
| `<leader>fh` | Normal | `help_tags` | **Help Tags**: Search Neovim help documentation |

### 🎯 Harpoon (Quick File Navigation)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>a` | Normal | `harpoon:list():add()` | **Add to Harpoon**: Mark current file in harpoon list |
| `<Ctrl-e>` | Normal | `toggle_quick_menu` | **Quick Menu**: Open harpoon's quick access menu |
| `<leader>fl` | Normal | `toggle_telescope` | **Harpoon List**: View harpoon files in Telescope picker |
| `<Ctrl-p>` | Normal | `harpoon:list():prev()` | **Previous**: Jump to previous file in harpoon list |
| `<Ctrl-n>` | Normal | `harpoon:list():next()` | **Next**: Jump to next file in harpoon list |

### 🧠 LSP (Language Server Protocol)
*Available only when LSP is active in supported file types*

#### Core Navigation
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `K` | Normal | `vim.lsp.buf.hover` | **Hover Documentation**: Show detailed info about symbol under cursor |
| `gd` | Normal | `vim.lsp.buf.definition` | **Go to Definition**: Jump to where symbol is defined |
| `gt` | Normal | `vim.lsp.buf.type_definition` | **Go to Type Definition**: Jump to type definition |
| `gr` | Normal | `vim.lsp.buf.references` | **Find References**: List all references to symbol |
| `gi` | Normal | `vim.lsp.buf.implementation` | **Go to Implementation**: Jump to implementation |

#### Code Actions
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>rn` | Normal | `vim.lsp.buf.rename` | **Rename Symbol**: Rename symbol across entire project |
| `<leader>ca` | Normal | `vim.lsp.buf.code_action` | **Code Actions**: Show available code fixes/refactors |

#### Diagnostics (Error/Warning Navigation)
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `[d` | Normal | `vim.diagnostic.goto_prev` | **Previous Diagnostic**: Jump to previous error/warning |
| `]d` | Normal | `vim.diagnostic.goto_next` | **Next Diagnostic**: Jump to next error/warning |
| `<leader>dl` | Normal | `vim.diagnostic.setloclist` | **Local Diagnostics**: Show current buffer's errors in location list |
| `<leader>da` | Normal | `vim.diagnostic.setqflist` | **All Diagnostics**: Show all workspace errors in quickfix list |

### ⌨️ Completion (Insert Mode)

#### Navigation
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<Tab>` | Insert/Select | Next item/Expand snippet | **Next/Expand**: Move to next completion or expand snippet |
| `<Shift-Tab>` | Insert/Select | Previous item/Jump back | **Previous/Jump**: Move to previous completion or jump back in snippet |
| `<Ctrl-Space>` | Insert | Force completion | **Manual Completion**: Manually trigger completion menu |

#### Documentation
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<Ctrl-b>` | Insert | Scroll docs up | **Scroll Up**: Scroll completion documentation upward |
| `<Ctrl-f>` | Insert | Scroll docs down | **Scroll Down**: Scroll completion documentation downward |

#### Selection
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<Enter>` | Insert | Confirm selection | **Accept**: Accept selected completion item |
| `<Ctrl-e>` | Insert | Abort completion | **Cancel**: Close completion menu without selecting |

## 🚀 Quick Start Workflows

### File Management Workflow
```
1. <leader>ff  → Find and open files
2. <leader>a   → Mark important files with Harpoon  
3. <Ctrl-e>    → Quick access to marked files
4. <leader>fb  → Switch between open buffers
```

### Development Workflow
```
1. gd          → Go to definition
2. K           → Read documentation
3. <leader>ca  → Apply code fixes
4. <leader>rn  → Rename variables/functions
5. [d / ]d     → Navigate through errors
```

### Search Workflow
```
1. <leader>fg  → Search text in entire project
2. <leader>fh  → Search help documentation
3. gr          → Find all references to symbol
```

## 🎨 Automatic Features

### No Keybindings Required
- **Auto-completion**: Triggers automatically while typing in supported file types
- **Diagnostic popups**: Error/warning details appear when cursor hovers (after 250ms)
- **Auto-format on save**: TypeScript/JavaScript files format automatically when saved
- **Syntax highlighting**: Treesitter provides enhanced syntax highlighting  
- **Color preview**: CSS colors are highlighted inline
- **Transparent background**: Elegant transparent terminal integration

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua              # Main configuration entry point
├── lua/
│   ├── config/
│   │   ├── options.lua   # Vim options and settings
│   │   ├── keybinds.lua  # Global keybindings
│   │   ├── lazy.lua      # Plugin manager setup
│   │   └── lsp.lua       # LSP configuration
│   └── plugins/
│       ├── cmp.lua       # Completion configuration
│       ├── colors.lua    # Theme and UI
│       ├── harpoon.lua   # File navigation
│       ├── telescope.lua # Fuzzy finder
│       ├── treesitter.lua# Syntax highlighting
│       └── oneliners.lua # Utility plugins
```

## 🔧 Supported Languages

| Language | LSP Server | Features |
|----------|------------|----------|
| **TypeScript/TSX** | `typescript-language-server` | Full IntelliSense, cross-file type checking, auto-imports |
| **JavaScript/JSX** | `typescript-language-server` | IntelliSense, ESLint integration, formatting |
| **PHP** | `intelephense` | Code completion, go-to definition, diagnostics |

## 💡 Pro Tips

### Effective Usage
1. **Start with `<leader>ff`** - This is your most-used command for opening files
2. **Master Harpoon** - Mark 4-5 key files with `<leader>a`, then use `<Ctrl-p>`/`<Ctrl-n>` to cycle
3. **Use LSP navigation** - `gd` and `gr` are essential for understanding code
4. **Navigate errors efficiently** - Use `]d` to jump through problems, `<leader>ca` to fix
5. **Search everything** - `<leader>fg` searches content, `<leader>ff` finds files

### TypeScript Development
- Ensure your project has a proper `tsconfig.json` for cross-file type checking
- Use `gt` to understand complex type definitions
- Leverage `<leader>rn` for safe refactoring across files

### Customization
- Leader key is `<Space>` - all custom commands start here
- LSP features only activate in supported file types
- All plugins are lazy-loaded for fast startup

## 🆘 Troubleshooting

### LSP Not Working
1. Verify language servers are installed globally
2. Check if `tsconfig.json` exists in project root
3. Restart Neovim after configuration changes

### Telescope Issues  
1. Install `ripgrep` and `fd` for full functionality
2. Ensure you're in a directory with files to search

### Performance Issues
1. All plugins are lazy-loaded by default
2. Consider excluding `node_modules` in project searches

---

**Happy coding with Neovim! 🎉**

*This configuration is optimized for Neovim 0.11+*
