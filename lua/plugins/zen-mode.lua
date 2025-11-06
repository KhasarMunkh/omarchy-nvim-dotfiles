return {
    "folke/zen-mode.nvim",
    lazy = true,
    opts = {},
    keys = {
       {
            "<leader>z",
            function()
                require("zen-mode").toggle()
            end,
            desc = "Toggle Zen Mode",
        },
    },
}
