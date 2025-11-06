if vim.g.vscode then
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)
    require("vim-options")
    require("vim-diagnostics")
    require("lazy").setup({
        spec = {
            { import = "plugins" },
        },
        git = {
            timeout = 600,
        },
    })
    -- Running inside VS Code
    -- Only load editing-focused plugins/keymaps
    -- local map = vim.keymap.set
    -- map("n", "<leader>gf", '<Cmd>call VSCodeNotify("editor.action.formatDocument")<CR>')
    -- map({ "n", "x" }, "gc", '<Cmd>call VSCodeNotifyVisual("editor.action.commentLine", 1)<CR>')
else
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)
    require("vim-options")
    require("vim-diagnostics")
    require("lazy").setup({
        spec = {
            { import = "plugins" },
        },
        git = {
            timeout = 600,
        },
    })
end
