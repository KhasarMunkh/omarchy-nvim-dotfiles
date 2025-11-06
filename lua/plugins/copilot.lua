return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_enabled = true

    function ToggleCopilot()
      if vim.g.copilot_enabled then
        vim.cmd("Copilot disable")
        vim.g.copilot_enabled = false
        vim.notify("🛑 Copilot disabled", vim.log.levels.INFO)
      else
        vim.cmd("Copilot enable")
        vim.g.copilot_enabled = true
        vim.notify("✅ Copilot enabled", vim.log.levels.INFO)
      end
    end

    vim.keymap.set("n", "<leader>cp", ToggleCopilot, { noremap = true, silent = true })
  end
}

