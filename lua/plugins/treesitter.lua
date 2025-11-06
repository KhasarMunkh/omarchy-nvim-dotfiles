-- return {
--   "nvim-treesitter/nvim-treesitter",
--   build = ":TSUpdate",
--   event = { "BufReadPost", "BufNewFile" }, -- lazy-load on files
--   opts = {
--     ensure_installed = {
--       "lua","python","javascript","typescript","tsx",
--       "c_sharp","go","markdown","markdown_inline",
--       "html","css","json","bash","svelte",
--     },
--     auto_install = true,         -- <— installs missing parsers on first open
--     highlight = { enable = true },
--     indent    = { enable = true },
--   },
--   config = function(_, opts)
--     require("nvim-treesitter.configs").setup(opts)
--   end,
-- }
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {
                    "lua",
                    "javascript",
                    "typescript",
                    "tsx",
                    "c_sharp",
                    "go",
                    "markdown",
                    "markdown_inline",
                    "html",
                    "css",
                    "json",
                    "bash",
                    "svelte",
                },
                highlight = { enable = true },
                indent = { enable = true },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                },
            })
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local rd = require("rainbow-delimiters")
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rd.strategy["global"],
                    commonlisp = rd.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
