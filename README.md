# Neovim Configuration

A feature-rich Neovim configuration with LSP, debugging, testing, and more. Supports multiple languages including JavaScript/TypeScript, Python, Go, C#, and others.

## Prerequisites

### Required

- **Neovim** >= 0.9.0 (recommend 0.10+)
- **Git**
- **Node.js** and **npm** (for many LSPs and formatters)
- **Python 3** with pip
- **A C compiler** (gcc/clang) for Telescope fzf-native

### Optional (Language-Specific)

- **Go** - for gopls, delve debugger, and Go formatters
- **.NET SDK** - for C# support (Roslyn LSP, csharpier)
- **Rust toolchain** - if working with Rust projects

## Installation

### 1. Backup Existing Config (if any)

```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
```

### 2. Clone This Repository

```bash
git clone <your-repo-url> ~/.config/nvim
```

### 3. Launch Neovim

```bash
nvim
```

On first launch:
- **lazy.nvim** will automatically bootstrap and install all plugins
- This may take a few minutes - let it complete
- You may see some error messages initially - this is normal

### 4. Install Language Servers

Once Neovim loads, open Mason:

```vim
:Mason
```

The following should auto-install (configured in `lua/plugins/lsp-config.lua`):
- lua_ls
- ts_ls (TypeScript/JavaScript)
- gopls (Go)
- tailwindcss
- emmet_language_server
- eslint
- html

**Additional manual installs** (in Mason):
- Press `i` to install packages
- Search for and install:
  - `pyright` (Python)
  - `clangd` (C/C++)
  - `prismals` (Prisma)
  - Any other language servers you need

### 5. Install Formatters & Linters

In Mason, also install these tools (used by none-ls):

**JavaScript/TypeScript:**
```bash
npm install -g @fsouza/prettierd
```

**Lua:**
- Search for `stylua` in Mason and install

**Python:**
```bash
pip install ruff
```

**Go:**
```bash
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

**C#:**
```bash
dotnet tool install -g csharpier
```

**C/C++:**
- Search for `clang-format` in Mason and install

### 6. Install Debug Adapters (Optional)

These should auto-install via mason-nvim-dap. Check with:

```vim
:Mason
```

Look for:
- `delve` (Go debugger)
- `js-debug-adapter` (JavaScript/TypeScript)
- `debugpy` (Python)
- `codelldb` (C/C++/Rust)

If missing, install them manually in Mason.

## Post-Installation

### Install Treesitter Parsers

Treesitter parsers auto-install on first file open, but you can manually trigger:

```vim
:TSInstall lua javascript typescript python go html css json
```

### Verify LSP is Working

1. Open a file (e.g., a `.js` or `.py` file)
2. Check LSP status:
   ```vim
   :LspInfo
   ```
3. You should see attached language servers

### Configure Project-Specific Tools

Some tools like `prettierd` and `eslint` look for project configurations. Make sure your projects have:
- `.prettierrc` or similar for Prettier
- `eslint.config.js` or `.eslintrc.*` for ESLint
- `tailwind.config.js` for Tailwind support

## Key Features

### Quick Reference

- `<Space>` is the leader key
- `<C-p>` - Fuzzy file finder
- `<C-n>` - File tree
- `<leader>fg` - Live grep
- `K` - LSP hover documentation
- `<leader>gf` - Format buffer
- `<leader>ca` - Code actions

See [CLAUDE.md](CLAUDE.md) for complete keybindings and features.

## Troubleshooting

### "LSP not working"

1. Check if the language server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Check logs: `:LspLog`
4. Restart LSP: `:LspRestart`

### "Formatter not working"

1. Verify the tool is installed (check with `which <tool>` in terminal)
2. For prettierd: `which prettierd`
3. For stylua: `which stylua`
4. Check none-ls status: `:NullLsInfo` or `:lua print(vim.inspect(require("null-ls").get_sources()))`

### "Treesitter highlighting broken"

```vim
:TSUpdate
```

### "Telescope not working"

Make sure fzf-native compiled correctly:
```bash
cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
make
```

### "Mason fails to install packages"

- Check internet connection
- Ensure you have git, curl, and unzip installed
- Try increasing timeout in init.lua (already set to 600s)

### Starting Fresh

If things are really broken:

```bash
# Remove plugin data
rm -rf ~/.local/share/nvim/lazy

# Remove state
rm -rf ~/.local/state/nvim

# Restart Neovim and let lazy.nvim reinstall
nvim
```

## VSCode Integration

This config also works with VSCode Neovim extension! The same configuration loads in both environments via the `vim.g.vscode` check in `init.lua`.

## Customization

- **Add plugins**: Create new files in `lua/plugins/`
- **Modify keymaps**: Edit `lua/vim-options.lua`
- **Change LSP settings**: Edit `lua/plugins/lsp-config.lua`
- **Adjust formatters**: Edit `lua/plugins/none-ls.lua`

## Notes System

This config includes a built-in notes system:
- `<leader>nn` - Create new timestamped note in `~/Notes`
- `<leader>nf` - Find notes
- `<leader>ng` - Search notes content

The `~/Notes` directory will be created automatically on first use.

## Credits

This configuration uses:
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [Mason](https://github.com/williamboman/mason.nvim) - LSP/DAP/linter installer
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion engine
- [Telescope](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- And many more amazing plugins!

## Support

For issues or questions about this configuration, see [CLAUDE.md](CLAUDE.md) for detailed documentation on the architecture and features.
