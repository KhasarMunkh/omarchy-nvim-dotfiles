return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",                             -- Optional: load on startup or when needed
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional but nice
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto",
                -- theme = "dracula",
                icons_enabled = true,
                globalstatus = true,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "filename", path = 1 } }, -- 0 = just name, 1 = relative, 2 = full
                lualine_x = { "encoding", "fileformat", "filetype", },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { "nvim-tree", "lazy", "quickfix", "fugitive" },
        })
    end
}
