return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- icons
        "MunifTanjim/nui.nvim",
    },

    -- load on demand: <C-n> or :Neotree
    keys = {
        {
            "<C-n>",
            function()
                vim.cmd("Neotree filesystem reveal float")
            end,
            desc = "Neo-tree: toggle",
        },
    },

    config = function()
        require("neo-tree").setup({
            sources = { "filesystem", "buffers" }, -- avoid auto-loading git_status source
            enable_git_status = false, -- turn off inline git status in the tree
            enable_diagnostics = true, -- turn off LSP diagnostics badges in the tree

            filesystem = {
                bind_to_cwd = true,
                use_libuv_file_watcher = true, -- faster, event-driven updates (can be great on SSDs)
                follow_current_file = { enabled = false }, -- stop constant folder jumping
                filtered_items = {
                    visible = false, -- keep hidden items hidden
                    hide_dotfiles = true,
                    hide_by_name = { ".git", "node_modules", "dist", "build", ".next" },
                    never_show = { ".DS_Store", "thumbs.db" },
                },
            },
        })
    end,
    -- config = function()
    --     require("neo-tree").setup({
    --         event_handlers = {
    --             {
    --                 event = "file_opened",
    --                 handler = function(_)
    --                     -- close the tree when you open a file
    --                     require("neo-tree.command").execute({ action = "close" })
    --                 end,
    --             },
    --         },
    --         ---- put any other neo-tree options here
    --         filesystem = {
    --             filtered_items = {
    --                 visible = true, -- show filtered items (like dotfiles)
    --                 hide_dotfiles = false, -- do NOT hide dotfiles
    --                 hide_gitignored = false,
    --             },
    --         },
    --     })
    -- end,
}
-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   branch = "v3.x",
--
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-tree/nvim-web-devicons",      -- icons
--     "MunifTanjim/nui.nvim",
--   },
--
--   -- load on demand: <C-n> or :Neotree
--   keys = {
--     { "<C-n>", function()
--         vim.cmd("Neotree toggle left")   -- open on left instead of float
--       end,
--       desc = "Neo-tree: toggle"
--     },
--   },
--
--   config = function()
--     require("neo-tree").setup({
--       -- event_handlers = {
--       --   {
--       --     event = "file_opened",
--       --     handler = function(_)
--       --       -- close the tree when you open a file
--       --       require("neo-tree.command").execute({ action = "close" })
--       --     end,
--       --   },
--       -- },
--       window = {
--         position = "left",  -- sidebar on the left
--         width = 30,
--       },
--         filesystem = {
--             filtered_items = {
--             visible = true,         -- show filtered items (like dotfiles)
--             hide_dotfiles = false,  -- do NOT hide dotfiles
--             hide_gitignored = false,
--             },
--         },
--     })
--   end,
-- }
