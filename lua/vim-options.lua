vim.opt.expandtab = true    -- Always insert spaces instead of tabs
vim.opt.tabstop = 4         -- Show existing tab characters as 2 spaces
vim.opt.softtabstop = 4     -- Tab key inserts 2 spaces
vim.opt.shiftwidth = 4      -- Indent by 2 spaces
vim.opt.smartindent = true -- Autoindent new lines

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "retab",
})

vim.g.mapleader = " "

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true                            -- Highlight the current line
-- write a command to toggle line wrapping
vim.opt.wrap = false                                 -- Disable line wrapping
vim.opt.scrolloff = 8                                -- Keep 8 lines visible above and below the cursor
vim.opt.sidescrolloff = 8                            -- Keep 8 columns visible to the left and right of the cursor
vim.opt.signcolumn = "yes"                           -- Always show the sign column
vim.opt.clipboard = "unnamedplus"                    -- Use the system clipboard for copy/paste
vim.opt.undofile = true                              -- Enable persistent undo
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo" -- Set the undo directory to a cache folder

--  below is for floating windows, like telescope, lsp hover, etc.
--  This is to make the background transparent
vim.opt.winblend = 10 -- Set the transparency level for floating windows
vim.opt.pumblend = 10 -- Set the transparency level for popup menus
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
-- keep it after colorscheme loads:
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
    end,
})

-- Split here, keep char under cursor before the break
vim.keymap.set("n", "<leader>o", "i<CR><Esc>", { desc = "Split line at cursor" })

-- Split after cursor (char under cursor goes to next line)
vim.keymap.set("n", "<leader>O", "a<CR><Esc>", { desc = "Split line after cursor" })

vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Move lines up and down
vim.keymap.set('n', '<CR>', 'm`o<Esc>``') -- Enter insert mode below the current line

vim.keymap.set('n', '<leader>h', ':split<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true })
-- create new window with the current file, the default keymap is <leader>n

-- Center the screen when scrolling

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- move cursor with scroll C-e, and C-u
vim.keymap.set('n', '<C-e>', '<C-e>j')
vim.keymap.set('n', '<C-y>', '<C-y>k')


-- Quick new note (timestamped) in your notes dir
vim.keymap.set("n", "<leader>nn", function()
  local notes = vim.fs.normalize(vim.fn.expand("~/Notes"))
  vim.fn.mkdir(notes, "p")
  local name = os.date("!%Y-%m-%d") .. ".md"
  vim.cmd.edit(notes .. "/" .. name)
  vim.cmd([[normal! gg]])
end, { desc = "Notes: New timestamped note" })

vim.keymap.set("n", "<leader>nf", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.expand("~/Notes"), hidden = true })
end, { desc = "Notes: Find file" })

vim.keymap.set("n", "<leader>ng", function()
  require("telescope.builtin").live_grep({ cwd = vim.fn.expand("~/Notes") })
end, { desc = "Notes: Grep notes" })

