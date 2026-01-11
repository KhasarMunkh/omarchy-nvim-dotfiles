require("no-neck-pain").setup({
	width = 120, -- Width of centered buffer (adjust to your preference)
	autocmds = {
		enableOnVimEnter = false, -- Don't auto-enable on startup
		enableOnTabEnter = false, -- Don't auto-enable when entering tab
	},
	buffers = {
		-- colors = {
		-- 	-- Use colorscheme background for side buffers
		-- 	background = "catppuccin-frappe",
		--           blend = -0.2,
		-- },
		bo = {
			filetype = "md",
		},
		wo = {
			cursorline = false,
			cursorcolumn = false,
			number = false,
			relativenumber = false,
			foldenable = false,
			list = false,
			wrap = true,
			linebreak = true,
		},
	},
})

-- Add keybinding to toggle
vim.keymap.set("n", "<leader>np", "<cmd>NoNeckPain<cr>", { desc = "Toggle No Neck Pain" })
