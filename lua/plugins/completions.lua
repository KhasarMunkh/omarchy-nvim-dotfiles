return {
    { "hrsh7th/cmp-nvim-lsp" },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "roobert/tailwindcss-colorizer-cmp.nvim" },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "roobert/tailwindcss-colorizer-cmp.nvim" },
        config = function()
            local cmp = require("cmp")
            local tailwind_fmt = require("tailwindcss-colorizer-cmp").formatter
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                completion = {
                    keyword_length = 1, -- Minimum word length to trigger completion
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                performance = {
                    max_view_entries = 10, -- Limit the number of entries in the completion menu
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),

                formatting = {
                    format = function(entry, item)
                        -- If you also use lspkind, apply it first, e.g.:
                        -- item = require("lspkind").cmp_format({ mode = "symbol_text" })(entry, item)
                        return tailwind_fmt(entry, item) -- inject Tailwind color squares
                    end,
                },

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" }, -- Add this for file path completion
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
}
