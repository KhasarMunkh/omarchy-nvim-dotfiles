return {
  "m00qek/baleia.nvim",  -- :contentReference[oaicite:0]{index=0}
  event   = "User DashboardLoaded",   -- dashboard fires this autocommand
  config  = function()
    local baleia = require("baleia").setup({ remember = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = "DashboardLoaded",
      callback = function()
        baleia.once(vim.api.nvim_get_current_buf())
      end,
    })
  end,
}
