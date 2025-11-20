vim.o.expandtab = true -- Always insert spaces instead of tabs
vim.o.tabstop = 4 -- Show existing tab characters as 2 spaces
vim.o.softtabstop = 4 -- Tab key inserts 2 spaces
vim.o.shiftwidth = 4 -- Indent by 2 spaces
vim.o.smartindent = true -- Autoindent new lines

vim.o.winborder = "rounded"
vim.o.termguicolors = true
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.swapfile = false
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true -- Persistent undo history
vim.o.undodir = vim.fn.stdpath("cache") .. "/undo" -- Store in cache dir

local map = vim.keymap.set
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic list" })
-- map ; to :
map("n", ";", ":", { noremap = true })
map("v", ";", ":", { noremap = true })
-- Easy escape from insert mode
map("i", "jk", "<Esc>", { noremap = true })
-- noremap means that the mapping won't be recursive(i.e., it won't trigger other mappings)

--map('n', '<leader>e', ":Oil<CR>")
map("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Oil floating" })
map("n", "<C-p>", "<cmd>Pick files<cr>", { desc = "Find files" })
-- Show ALL files including gitignored
map("n", "<leader>pa", function()
	local MiniPick = require("mini.pick")
	local items = vim.fn.systemlist("rg --files --hidden --no-ignore")
	MiniPick.start({ source = { items = items } })
end, { desc = "Find ALL files (no gitignore)" })
map("n", "<C-h>", "<cmd>Pick help<cr>", { desc = "Find help" })
map("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { desc = "Live grep" })
map("n", "<CR>", "m`o<Esc>``") -- Enter insert mode below the current line

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-e>", "<C-e>j")
map("n", "<C-y>", "<C-y>k")

--map('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })
map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>gr", vim.lsp.buf.references, { desc = "Find references" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })

-- Quickfix navigation
map("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Next in quickfix" })
map("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Prev in quickfix" })

-- Copilot toggle function
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

map("n", "<leader>cp", ToggleCopilot, { desc = "Toggle Copilot" })

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" }, -- colorscheme
	{ src = "https://github.com/nvim-lualine/lualine.nvim" }, -- statusline
	{ src = "https://github.com/lewis6991/gitsigns.nvim" }, -- git signs in gutter
	{ src = "https://github.com/catppuccin/nvim" }, -- Catppuccin colorscheme
	{ src = "https://github.com/stevearc/oil.nvim" }, -- file explorer
	{ src = "https://github.com/echasnovski/mini.nvim" }, -- mini.pick (and other mini modules)
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/HiPhish/rainbow-delimiters.nvim" }, -- rainbow brackets
	{ src = "https://github.com/mason-org/mason.nvim" }, -- LSP installer
	{ src = "https://github.com/neovim/nvim-lspconfig" }, -- LSP configurations

	-- Completion & Snippets
	{ src = "https://github.com/hrsh7th/nvim-cmp" }, -- Completion engine
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" }, -- LSP completion source
	{ src = "https://github.com/hrsh7th/cmp-buffer" }, -- Buffer completion source
	{ src = "https://github.com/hrsh7th/cmp-path" }, -- Path completion source
	{ src = "https://github.com/L3MON4D3/LuaSnip" }, -- Snippet engine
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" }, -- LuaSnip completion source
	{ src = "https://github.com/rafamadriz/friendly-snippets" }, -- Snippet collection
	{ src = "https://github.com/roobert/tailwindcss-colorizer-cmp.nvim" }, -- Tailwind colors in completion

	-- GitHub Copilot
	{ src = "https://github.com/github/copilot.vim" }, -- GitHub Copilot AI completion

	-- Formatting & Linting
	{ src = "https://github.com/stevearc/conform.nvim" }, -- Formatter runner
	{ src = "https://github.com/mfussenegger/nvim-lint" }, -- Linter runner
})
require("mason").setup()
require("mini.icons").setup()
require("mini.pick").setup()
require("plugins.lualine")
require("plugins.gitsigns")

-- mini.surround - Surround text objects with quotes, brackets, etc.
require("mini.surround").setup({
	mappings = {
		add = "sa", -- Add surrounding in Normal and Visual modes
		delete = "sd", -- Delete surrounding
		find = "sf", -- Find surrounding (to the right)
		find_left = "sF", -- Find surrounding (to the left)
		highlight = "sh", -- Highlight surrounding
		replace = "sr", -- Replace surrounding
		update_n_lines = "sn", -- Update `n_lines`
		suffix_last = "l", -- Suffix to search with "prev" method
		suffix_next = "n", -- Suffix to search with "next" method
	},
	n_lines = 20,
	respect_selection_type = false,
	search_method = "cover",
	highlight_duration = 500,
})

-- mini.splitjoin - Split/join arguments, arrays, etc.
require("mini.splitjoin").setup({
	mappings = { toggle = "" }, -- Disable default toggle mapping
})
-- Custom keybindings for split/join
map({ "n", "x" }, "sj", function()
	require("mini.splitjoin").join()
end, { desc = "Join arguments" })

map({ "n", "x" }, "sk", function()
	require("mini.splitjoin").split()
end, { desc = "Split arguments" })

require("oil").setup({
	skip_confirm_for_simple_edits = true,
	keymaps = {
		["q"] = "actions.close",
		["<Esc>"] = "actions.close",
	},
})

-- Completion setup
local cmp = require("cmp")
local luasnip = require("luasnip")
local tailwind_fmt = require("tailwindcss-colorizer-cmp").formatter

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
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
		max_view_entries = 10, -- Limit completion menu entries
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		-- Tab for next completion item
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		-- Shift-Tab for previous completion item
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		format = function(entry, item)
			return tailwind_fmt(entry, item) -- Show Tailwind colors
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
})

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"javascript",
		"typescript",
		"tsx",
		"python",
		"go",
		"c",
		"cpp",
		"html",
		"css",
	},
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
})

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
	strategy = {
		[""] = "rainbow-delimiters.strategy.global",
		vim = "rainbow-delimiters.strategy.local",
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	priority = {
		[""] = 110,
		lua = 210,
	},
	highlight = {
		"RainbowDelimiterRed",
		"RainbowDelimiterYellow",
		"RainbowDelimiterBlue",
		"RainbowDelimiterOrange",
		"RainbowDelimiterGreen",
		"RainbowDelimiterViolet",
		"RainbowDelimiterCyan",
	},
}

-- LSP Configuration (Modern Neovim 0.11+ approach)

-- Configure diagnostics (inline error messages)
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
		source = "if_many", -- Show source name if multiple LSPs
	},
	signs = true, -- Show icons in gutter
	underline = true, -- Underline errors/warnings
	update_in_insert = false, -- Don't update while typing
	severity_sort = true, -- Sort by severity
})

-- Add nvim-cmp capabilities to LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enable LSP servers (uses configs from lsp/ directory or nvim-lspconfig)
vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"pyright",
	"gopls",
	"cssls",
	"eslint",
	"html",
	"tailwindcss",
	"clangd",
	"svelte",
})

-- Override specific server settings (all inherit capabilities)
vim.lsp.config["*"] = {
	capabilities = capabilities,
}
vim.lsp.config.pyright = {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
}

vim.lsp.config.gopls = {
	settings = {
		gopls = {
			diagnosticsDelay = "500ms",
			experimentalPostfixCompletions = true,
		},
	},
}

vim.lsp.config.cssls = {
	settings = {
		css = { validate = true, lint = { unknownAtRules = "ignore" } },
		scss = { validate = true, lint = { unknownAtRules = "ignore" } },
		less = { validate = true, lint = { unknownAtRules = "ignore" } },
	},
}

vim.lsp.config.eslint = {
	settings = {
		workingDirectory = { mode = "auto" },
		format = { enable = false },
		codeAction = { disableRuleComment = { location = "separateLine" } },
	},
}

vim.lsp.config.tailwindcss = {
	filetypes = {
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className" },
			experimental = {
				classRegex = {
					'class(?:Name)?="([^"]*)"',
					"class(?:Name)?=\\{`([^`]*)`\\}",
					"clsx\\(([^\\)]*)\\)",
					"cn\\(([^\\)]*)\\)",
				},
			},
			colorDecorators = { enable = true },
		},
	},
}

-- Conform.nvim - Formatting (replaces none-ls formatters)
require("conform").setup({
	formatters_by_ft = {
		-- Lua
		lua = { "stylua" },

		-- JavaScript/TypeScript/Web
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },

		-- C#
		cs = { "csharpier" },

		-- C/C++
		c = { "clang_format" },
		cpp = { "clang_format" },

		-- Go
		go = { "gofumpt", "goimports" },

		-- Python
		python = { "ruff_format" },
	},
	formatters = {
		prettierd = {
			env = {
				PRETTIERD_LOCAL_PRETTIER_ONLY = "1", -- Prefer project prettier if present
			},
		},
	},
})

-- Hook conform into vim.lsp.buf.format() for consistency with old config
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, { buffer = args.buf, desc = "Format buffer" })
	end,
})

-- nvim-lint - Linting (replaces none-ls diagnostics)
local lint = require("lint")

lint.linters_by_ft = {
	go = { "golangcilint" },
	python = { "ruff" },
}

-- Run linters on save and buffer enter
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
	callback = function()
		lint.try_lint()
	end,
})

require("vague").setup({ transparent = true })
vim.cmd("colorscheme catppuccin-macchiato")
--vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
