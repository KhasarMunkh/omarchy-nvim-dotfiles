local _99 = require("99")

-- Debug logging to /tmp based on project name
local cwd = vim.uv.cwd()
local basename = vim.fs.basename(cwd)

_99.setup({
    -- provider = _99.ClaudeCodeProvider,  -- default: OpenCodeProvider
    logger = {
        level = _99.DEBUG,
        path = "/tmp/" .. basename .. ".99.debug",
        print_on_error = true,
    },

    --- Completions: #rules and @files in the prompt buffer
    completion = {
        --- Configure @file completion (all fields optional, sensible defaults)
        files = {
            -- enabled = true,
            -- max_file_size = 102400,     -- bytes, skip files larger than this
            -- max_files = 5000,           -- cap on total discovered files
        },

        --- What autocomplete do you use (currently only cmp supported)
        source = "cmp",
    },

    --- Auto-attach AGENT.md files found walking up from the current file
    --- to the project root (based on cwd)
    md_files = {
        "AGENT.md",
    },
})

-- Visual select code, then <leader>9v to open AI prompt scoped to that selection
vim.keymap.set("v", "<leader>9v", function()
    _99.visual()
end, { desc = "99: AI visual request" })

-- Stop/cancel all active AI requests
vim.keymap.set("v", "<leader>9s", function()
    _99.stop_all_requests()
end, { desc = "99: Stop all requests" })
