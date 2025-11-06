-- vim.diagnostic.config({
--   virtual_text = {
--     prefix = "●",      -- "" keeps the default ▸  |  "●" looks clean
--     spacing = 2,
--     source  = "if_many", -- show the LSP name if >1 client
--   },
--   signs = true,          -- ▌ gutter icons
--   underline = true,      -- colored underline
--   update_in_insert = false, -- don’t flicker while typing
--   severity_sort = true,
-- })
-- Gutter signs 
do
  local signs = {
    Error = "💥",
    Warn  = "⚠️",
    Info  = "🛈",
    Hint  = "💡",
  }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end
end

-- 2) Virtual text with a severity-specific icon
vim.diagnostic.config({
  virtual_text = {
    -- You can keep a static prefix *or* format each message with an icon:
    -- prefix = "●",

    -- Add the icon right before the message:
    format = function(d)
      local s = vim.diagnostic.severity
      local icons = {
        [s.ERROR] = "💥",
        [s.WARN]  = "⚠️",
        [s.INFO]  = "🛈",
        [s.HINT]  = "💡",
      }
      local icon = icons[d.severity] or "●"
      return string.format("%s %s", icon, d.message)
    end,

    spacing = 2,
    source  = "if_many",
  },
  signs = true,          -- ▌ gutter icons
  underline = true,      -- colored underline
  update_in_insert = false, -- don’t flicker while typing
  severity_sort = true,
})

vim.api.nvim_create_user_command("ToggleDiagnostics", function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle inline diagnostics" })

vim.keymap.set("n", "<leader>hd", "<cmd>ToggleDiagnostics<cr>", { desc = "Toggle inline diagnostics" })
