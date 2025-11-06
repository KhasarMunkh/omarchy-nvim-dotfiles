# Neovim Configuration

A feature-rich Neovim configuration with LSP, debugging, testing, and more. Supports multiple languages including JavaScript/TypeScript, Python, Go, C#, Rust, and others.

**Note**: This config uses **Mason** to install LSP servers, formatters, linters, and debug adapters directly from Neovim.

## Prerequisites

### System Packages (Arch Linux/OmArchy)

```bash
# Essential build tools (required for Mason and Telescope)
sudo pacman -S base-devel

# Core dependencies
sudo pacman -S git curl unzip wget tar gzip
sudo pacman -S neovim           # Neovim >= 0.9.0 (recommend 0.10+)
sudo pacman -S nodejs npm       # For many LSPs and formatters
sudo pacman -S python python-pip

# Optional: Language-specific toolchains
sudo pacman -S go               # For Go development
sudo pacman -S rust rust-analyzer # For Rust development
sudo pacman -S dotnet-sdk       # For C# development
sudo pacman -S clang            # For C/C++ development
```

**Alternative**: You can install most LSPs/formatters via Mason instead of pacman. Mason installs everything to `~/.local/share/nvim/mason/` without requiring root.

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

### 4. Install Language Servers via Mason

**Mason** is a Neovim package manager that installs LSP servers, formatters, linters, and debuggers.

Once Neovim loads, open Mason:

```vim
:Mason
```

The following **auto-install** on first launch (configured in `lua/plugins/lsp-config.lua`):
- `lua_ls` - Lua
- `ts_ls` - TypeScript/JavaScript
- `gopls` - Go
- `tailwindcss` - Tailwind CSS
- `emmet_language_server` - HTML/CSS
- `eslint` - JavaScript/TypeScript linter
- `html` - HTML

**Additional LSPs to install manually** (in Mason UI):
- Press `/` to search, then `i` to install:
  - `pyright` - Python LSP
  - `clangd` - C/C++ LSP (or use system package)
  - `rust-analyzer` - Rust LSP (or use system package)
  - `prismals` - Prisma ORM
  - Any other language servers you need

### 5. Install Formatters & Linters

**Option A: Via Mason (Recommended)**

Open Mason (`:Mason`), search and install:
- `stylua` - Lua formatter
- `prettierd` - JavaScript/TypeScript/JSON/Markdown formatter
- `clang-format` - C/C++ formatter

**Option B: Via Language Package Managers**

Some tools must be installed via their language's package manager:

**Python:**
```bash
pip install ruff  # Formatter + linter
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

**Rust:**
- No additional tools needed - `rustfmt` and `clippy` come with Rust toolchain

**JavaScript/TypeScript (alternative to Mason):**
```bash
npm install -g @fsouza/prettierd
```

### 6. Install Debug Adapters via Mason (Optional)

Debug adapters (DAP) **auto-install** via `mason-nvim-dap`. Verify with:

```vim
:Mason
```

These should be installed automatically:
- `delve` - Go debugger
- `js-debug-adapter` - JavaScript/TypeScript debugger
- `debugpy` - Python debugger
- `codelldb` - C/C++/Rust debugger

If missing, search and install them manually in Mason (press `/` to search, `i` to install).

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
