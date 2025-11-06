return {
    {
        "lewis6991/hover.nvim",
        config = function()
            require("hover").setup({
                init = function()
                    require("hover.providers.lsp")
                    -- optional extras:
                    -- require("hover.providers.gh")
                    -- require("hover.providers.gh_user")
                    require("hover.providers.man")
                end,
                preview_opts = {
                    border = "rounded",
                    max_width = math.floor(vim.o.columns * 0.6),
                    max_height = math.floor(vim.o.lines * 0.6),
                },
                title = true,
            })
            -- Keymaps: call the functions, and pass {} to avoid the nil-opts bug
            vim.keymap.set("n", "K", function()
                -- Try hover.nvim; if it returns false, fall back to LSP hover
                if not require("hover").hover({}) then
                    if vim.lsp.buf.hover then
                        vim.lsp.buf.hover()
                    end
                end
            end, { desc = "Hover" })

            vim.keymap.set("n", "gK", function()
                require("hover").hover_select({}) -- <= note the {}
            end, { desc = "Hover (select source)" })
        end,
        -- vim.keymap.set("n", "K", require("hover").hover, { desc = "Hover" })
        -- vim.keymap.set("n", "gK", require("hover").hover_select({}), { desc = "Hover (select source)" })
        -- end,
    },
}

-- Requires:
--   - lewis6991/hover.nvim
--   - 3rd/image.nvim configured with integrations.markdown.floating_windows = true
-- Notes:
--   - For SVG/data: URIs, ensure ImageMagick + librsvg are installed.
--   - Test outside tmux; tmux blocks kitty/ghostty graphics.
