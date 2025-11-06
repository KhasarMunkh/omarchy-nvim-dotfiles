return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- Lua
                null_ls.builtins.formatting.stylua,
                -- JavaScript/TypeScript
                --
                null_ls.builtins.formatting.prettierd.with({
                    filetypes = {
                        "javascript",
                        "typescript",
                        "javascriptreact",
                        "typescriptreact",
                        "css",
                        "json",
                        "markdown",
                        },
                    env = { PRETTIERD_LOCAL_PRETTIER_ONLY = "1" }, -- prefer project prettier if present
                }),

                null_ls.builtins.formatting.csharpier,
                null_ls.builtins.formatting.clang_format,

                -- Golang
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.diagnostics.golangci_lint,

                -- Python
                null_ls.builtins.formatting.ruff,
                null_ls.builtins.diagnostics.ruff,
            },
        })
        local original_show = vim.diagnostic.show
        vim.diagnostic.show = function(namespace, bufnr, diagnostics, opts)
            if type(diagnostics) ~= "table" then
                -- fallback to original if diagnostics is nil or not a table
                return original_show(namespace, bufnr, diagnostics, opts)
            end

            local function deduplicate_diagnostics(diags)
                local seen, result = {}, {}
                for _, d in ipairs(diags) do
                    local key = string.format("%d:%d:%s", d.lnum, d.col, d.message)
                    if not seen[key] then
                        seen[key] = true
                        table.insert(result, d)
                    end
                end
                return result
            end

            return original_show(namespace, bufnr, deduplicate_diagnostics(diagnostics), opts)
        end

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
