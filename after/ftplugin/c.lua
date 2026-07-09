-- Neovim's cpp ftplugin sources c.lua too, so this covers both C and C++.
-- Treesitter indent is disabled for c/cpp (init.lua) because its indentexpr
-- overrides cindent and doesn't indent namespace bodies.
vim.opt_local.indentexpr = "" -- make sure nothing overrides cindent
vim.opt_local.cindent = true
-- cindent indents namespace bodies by one shiftwidth by default, which matches
-- clang-format NamespaceIndentation: All (do NOT add Ns — that doubles it).
-- g2: 'public:'/'private:' at 2 spaces inside class (clang-format AccessModifierOffset: -2)
vim.opt_local.cinoptions = "g2"
