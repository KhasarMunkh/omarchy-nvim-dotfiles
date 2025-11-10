vim.o.expandtab = true   -- Always insert spaces instead of tabs
vim.o.tabstop = 4        -- Show existing tab characters as 2 spaces
vim.o.softtabstop = 4    -- Tab key inserts 2 spaces
vim.o.shiftwidth = 4     -- Indent by 2 spaces
vim.o.smartindent = true -- Autoindent new lines

vim.o.winborder = "rounded"
vim.o.termguicolors = true
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.swapfile = false
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true                              -- Persistent undo history
vim.o.undodir = vim.fn.stdpath('cache') .. '/undo' -- Store in cache dir


local map = vim.keymap.set
map('n', '<leader>f', vim.lsp.buf.format)
--map('n', '<leader>e', ":Oil<CR>")
map('n', '<leader>e', '<CMD>Oil --float<CR>', { desc = 'Oil floating' })
map('n', '<C-p>', '<cmd>Pick files<cr>', { desc = 'Find files' })
-- Show ALL files including gitignored
map('n', '<leader>pa', function()
    local MiniPick = require('mini.pick')
    local items = vim.fn.systemlist('rg --files --hidden --no-ignore')
    MiniPick.start({ source = { items = items } })
end, { desc = 'Find ALL files (no gitignore)' })
map('n', '<C-h>', '<cmd>Pick help<cr>', { desc = 'Find help' })
map('n', '<leader>fg', '<cmd>Pick grep_live<cr>', { desc = 'Live grep' })
map('n', '<CR>', 'm`o<Esc>``') -- Enter insert mode below the current line

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-e>', '<C-e>j')
vim.keymap.set('n', '<C-y>', '<C-y>k')

vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },              -- colorscheme
    { src = "https://github.com/stevearc/oil.nvim" },               -- file explorer
    { src = "https://github.com/echasnovski/mini.nvim" },           -- mini.pick (and other mini modules)
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/HiPhish/rainbow-delimiters.nvim" }, -- rainbow brackets
    { src = "https://github.com/mason-org/mason.nvim" },            -- LSP installer
})
require "mason".setup()
require 'mini.icons'.setup()
require 'mini.pick'.setup()
require "oil".setup({
    keymaps = {
        ["q"] = "actions.close",
        ["<Esc>"] = "actions.close",
    },
})

require "nvim-treesitter.configs".setup({
    ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "go",
        "c",
        "cpp",
        "html",
        "css",
    },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
})

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
    strategy = {
        [''] = 'rainbow-delimiters.strategy.global',
        vim = 'rainbow-delimiters.strategy.local',
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}

vim.lsp.enable({ 'lua_ls' })
require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
