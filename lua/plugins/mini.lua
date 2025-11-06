-- return mini.sorround please1
-- This file is part of Mini.nvim.
return {
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup(
                {
                    custom_surroundings = nil,
                    highlight_duration = 500,
                    -- Module mappings. Use `''` (empty string) to disable one.
                    mappings = {
                        add = 'sa',            -- Add surrounding in Normal and Visual modes
                        delete = 'sd',         -- Delete surrounding
                        find = 'sf',           -- Find surrounding (to the right)
                        find_left = 'sF',      -- Find surrounding (to the left)
                        highlight = 'sh',      -- Highlight surrounding
                        replace = 'sr',        -- Replace surrounding
                        update_n_lines = 'sn', -- Update `n_lines`
                        suffix_last = 'l',     -- Suffix to search with "prev" method
                        suffix_next = 'n',     -- Suffix to search with "next" method
                    },

                    -- Number of lines within which surrounding is searched
                    n_lines = 20,

                    -- Whether to respect selection type:
                    -- - Place surroundings on separate lines in linewise mode.
                    -- - Place surroundings on each line in blockwise mode.
                    respect_selection_type = false,

                    -- How to search for surrounding (first inside current line, then inside
                    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
                    -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
                    -- see `:h MiniSurround.config`.
                    search_method = 'cover',

                    -- Whether to disable showing non-error feedback
                    -- This also affects (purely informational) helper messages shown after
                    -- idle time if user input is required.
                    silent = false,
                })
        end,
    },
    {
        "echasnovski/mini.splitjoin",
        event = "VeryLazy",
        config = function()
            local miniSplitjoin = require("mini.splitjoin")
            miniSplitjoin.setup({
                mappings = { toggle = "" }, -- Disable default mapping
            })

            -- {"n", "x"} for normal and visual mode
            vim.keymap.set({ "n", "x" }, "sj", function(
            )
                miniSplitjoin.join()
            end, { desc = "join arguments" })

            vim.keymap.set({ "n", "x" }, "sk", function()
                miniSplitjoin.split()
            end, { desc = "Split arguments" })
        end,
    },

}
