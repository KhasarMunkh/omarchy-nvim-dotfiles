return {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    config = function()
        require("lsp_signature").setup({
            bind = true,            -- This is mandatory, otherwise border config won't get registered.
            handler_opts = {
                border = "rounded", -- double, rounded, single, shadow, none
            },
            floating_window = false, -- set to true to enable floating window
            floating_window_above_cur_line = true,
            fix_pos = true,
            toggle_key = "<M-s>",                         -- insert mode: Alt-s to toggle hints on/off
            select_signature_key = "<M-n>",               -- cycle overloads (optional), defau
            hi_parameter = "LspSignatureActiveParameter", -- Highlight the current parameter
        })
    end,
}
