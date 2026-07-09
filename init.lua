vim.o.background = "dark" -- set so nvim doesnt change colorscheme when switching between light/dark terminal themes
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.expandtab = true -- Always insert spaces instead of tabs

vim.o.tabstop = 4 -- Show existing tab characters as 4 spaces
vim.o.softtabstop = 4 -- Tab key inserts 4 spaces
vim.o.shiftwidth = 4 -- Indent by 4 spaces

-- vim.o.tabstop = 2 -- Show existing tab characters as 2 spaces
-- vim.o.softtabstop = 2 -- Tab key inserts 2 spaces
-- vim.o.shiftwidth = 2 -- Indent by 2 spaces

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
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic list" })
-- map ; to :
map("n", ";", ":", { noremap = true })
map("v", ";", ":", { noremap = true })
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

-- Center cursor after jumping (zz = center, zv = open folds)
map("n", "<C-d>", "<C-d>zz") -- half page down
map("n", "<C-u>", "<C-u>zz") -- half page up
map("n", "<C-e>", "<C-e>j")
map("n", "<C-y>", "<C-y>k")
map("n", "n", "nzzzv") -- next search match
map("n", "N", "Nzzzv") -- prev search match
map("n", "*", "*zzzv") -- search word under cursor (forward)
map("n", "#", "#zzzv") -- search word under cursor (backward)
map("n", "G", "Gzz") -- end of file
map("n", "gg", "ggzz") -- start of file
map("n", "%", "%zz") -- matching bracket
map("n", "{", "{zz") -- prev paragraph
map("n", "}", "}zz") -- next paragraph
map("n", "<C-o>", "<C-o>zz") -- jumplist back
map("n", "<C-i>", "<C-i>zz") -- jumplist forward

--map('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })
map("n", "<leader>gd", function()
	vim.lsp.buf.definition()
	-- defer so the jump completes before centering
	vim.defer_fn(function()
		vim.cmd("normal! zz")
	end, 100)
end, { desc = "Go to definition" })
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>gr", vim.lsp.buf.references, { desc = "Find references" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })

-- Quickfix navigation
map("n", "<M-j>", "<cmd>cnext<CR>zz", { desc = "Next in quickfix" })
map("n", "<M-k>", "<cmd>cprev<CR>zz", { desc = "Prev in quickfix" })


-- Close quickfix if open, otherwise open it
map("n", "<leader>k", vim.cmd.cclose, { desc = "Close quickfix list" })


-- Compile command (Emacs-style M-x compile)
-- Prompts for a shell command, runs it async, populates quickfix with errors
local last_compile_cmd = "make"
local function compile(cmd)
	if not cmd or cmd == "" then return end
	last_compile_cmd = cmd
	-- Clear quickfix and open it at 1/3 screen height
	vim.fn.setqflist({}, "r")
	vim.cmd("copen " .. math.floor(vim.o.lines / 3))
	vim.fn.setqflist({}, "r", { title = "compiling: " .. cmd })

	local output_lines = {}
	vim.system(vim.list_extend({ "sh", "-c" }, { cmd }), {
		stdout = function(_, data)
			if data then
				for line in data:gmatch("[^\r\n]+") do
					table.insert(output_lines, line)
				end
			end
		end,
		stderr = function(_, data)
			if data then
				for line in data:gmatch("[^\r\n]+") do
					table.insert(output_lines, line)
				end
			end
		end,
	}, function(result)
		vim.schedule(function()
			-- Parse output into quickfix entries using errorformat
			vim.fn.setqflist({}, "r", {
				title = cmd,
				lines = output_lines,
				efm = vim.o.errorformat,
			})
			vim.cmd("copen " .. math.floor(vim.o.lines / 3))
			-- Scroll to bottom of quickfix to show latest output
			vim.cmd("cbottom")
			if result.code == 0 then
				vim.notify("Compilation finished successfully", vim.log.levels.INFO)
			else
				vim.notify("Compilation failed (exit " .. result.code .. ")", vim.log.levels.ERROR)
			end
		end)
	end)
end

vim.api.nvim_create_user_command("Compile", function(opts)
	if opts.args ~= "" then
		compile(opts.args)
	else
		vim.ui.input({ prompt = "Compile command: ", default = last_compile_cmd }, compile)
	end
end, { nargs = "?", desc = "Run compile command (like Emacs M-x compile)" })

-- Recompile: re-run the last compile command without prompting
vim.api.nvim_create_user_command("Recompile", function()
	compile(last_compile_cmd)
end, { desc = "Re-run last compile command" })

map("n", "<leader>cc", "<cmd>Compile<CR>", { desc = "Compile (prompt)" })
map("n", "<leader>cr", "<cmd>Recompile<CR>", { desc = "Recompile last" })

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
	{ src = "https://github.com/andrewferrier/wrapping.nvim" },
	{ src = "https://github.com/vague2k/vague.nvim" }, -- colorscheme
	{ src = "https://github.com/deparr/tairiki.nvim" }, -- colorscheme
	{ src = "https://github.com/bjarneo/ethereal.nvim" }, -- colorscheme
	{ src = "https://github.com/tahayvr/matteblack.nvim" }, -- colorscheme
	{ src = "https://github.com/folke/tokyonight.nvim" }, -- colorscheme
	{ src = "https://github.com/rebelot/kanagawa.nvim" }, -- colorscheme

	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" }, -- file explorer
	{ src = "https://github.com/MunifTanjim/nui.nvim" }, -- neo-tree dependency
	{ src = "https://github.com/nvim-lua/plenary.nvim" }, -- neo-tree dependency

	{ src = "https://github.com/nvim-lualine/lualine.nvim" }, -- statusline
	{ src = "https://github.com/nvimdev/dashboard-nvim" }, -- dashboard
	{ src = "https://github.com/lewis6991/gitsigns.nvim" }, -- git signs in gutter
	{ src = "http://github.com/shortcuts/no-neck-pain.nvim" }, -- focus mode(centered buffer)
	{ src = "https://github.com/catppuccin/nvim" }, -- catppuccin colorscheme
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" }, -- gruvbox colorscheme
	{ src = "https://github.com/edeneast/nightfox.nvim" }, -- nightfox colorscheme
	{ src = "https://github.com/stevearc/oil.nvim" }, -- file explorer
	{ src = "https://github.com/meanderingprogrammer/render-markdown.nvim" }, -- markdown renderer
	{ src = "https://github.com/echasnovski/mini.nvim" }, -- mini.pick (and other mini modules)
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" }, -- auto close/rename html tags
	{ src = "https://github.com/hiphish/rainbow-delimiters.nvim" }, -- rainbow brackets
	{ src = "https://github.com/mason-org/mason.nvim" }, -- lsp installer
	{ src = "https://github.com/neovim/nvim-lspconfig" }, -- lsp configurations
	{ src = "https://github.com/ray-x/lsp_signature.nvim" }, -- lsp function signature hints

	-- completion & snippets
	{ src = "https://github.com/hrsh7th/nvim-cmp" }, -- completion engine
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" }, -- lsp completion source
	{ src = "https://github.com/hrsh7th/cmp-buffer" }, -- buffer completion source
	{ src = "https://github.com/hrsh7th/cmp-path" }, -- path completion source
	{ src = "https://github.com/l3mon4d3/luasnip" }, -- snippet engine
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" }, -- luasnip completion source
	{ src = "https://github.com/rafamadriz/friendly-snippets" }, -- snippet collection
	{ src = "https://github.com/roobert/tailwindcss-colorizer-cmp.nvim" }, -- tailwind colors in completion

	-- github copilot
	{ src = "https://github.com/github/copilot.vim" }, -- github copilot ai completion

	-- formatting & linting
	{ src = "https://github.com/stevearc/conform.nvim" }, -- formatter runner
	{ src = "https://github.com/mfussenegger/nvim-lint" }, -- linter runner

	-- c++ enhancements
	{ src = "https://github.com/p00f/clangd_extensions.nvim" }, -- clangd extras (type hierarchy, ast, symbol info)

	-- AI agent
	{ src = "https://github.com/ThePrimeagen/99" }, -- ThePrimeagen's scoped AI agent
})
require("plugins.dashboard")
require("mason").setup()
require("mini.icons").setup()
require("mini.pick").setup({
	window = {
		config = function()
			local height = math.floor(0.6 * vim.o.lines)
			local width = math.floor(0.5 * vim.o.columns)
			return {
				anchor = "NW",
				height = height,
				width = width,
				row = math.floor(0.5 * (vim.o.lines - height)),
				col = math.floor(0.5 * (vim.o.columns - width)),
				border = "rounded",
			}
		end,
	},
})
require("mini.pairs").setup()
require("plugins.wrapping")
require("plugins.lsp_signature")
require("plugins.lualine")
require("plugins.gitsigns")
require("plugins.no-neck-pain")
require("plugins.render-markdown")
require("plugins.99")

-- Neo-tree file explorer
require("neo-tree").setup({
	close_if_last_window = true,
	window = {
		position = "left",
		width = 30,
	},
	filesystem = {
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
	},
})
vim.keymap.set("n", "<leader>t", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })

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
	float = {
		padding = 2,
		max_width = 80,
		max_height = 30,
		border = "rounded",
		win_options = {
			winblend = 0,
		},
	},
})

-- Toggle diagnostics command
vim.api.nvim_create_user_command("ToggleDiagnostics", function()
	local current = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle inline diagnostics" })
map("n", "<leader>hd", "<cmd>ToggleDiagnostics<cr>", { desc = "Toggle inline diagnostics" })

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
        "java",
	},
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	-- Treesitter indent overrides cindent via indentexpr; its C/C++ queries don't
	-- indent namespace bodies (clang-format NamespaceIndentation: All), so use
	-- cindent for those filetypes instead (see after/ftplugin/c.lua)
	indent = { enable = true, disable = { "c", "cpp" } },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
})

-- Auto close/rename HTML tags
require("nvim-ts-autotag").setup({
	opts = {
		enable_close = true, -- Auto close tags
		enable_rename = true, -- Auto rename pairs
		enable_close_on_slash = true, -- Auto close on </
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
    "jdtls",
})

-- Override specific server settings (all inherit capabilities)
vim.lsp.config["*"] = {
	capabilities = capabilities,
}
vim.lsp.config.pyright = {
	before_init = function(_, config)
		-- Auto-detect .venv created by uv
		local venv = vim.fn.getcwd() .. "/.venv/bin/python"
		if vim.fn.filereadable(venv) == 1 then
			config.settings.python.pythonPath = venv
		end
	end,
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
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
		"svelte",
		"astro",
		"htmlangular",
	},
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

vim.lsp.config.clangd = {
	cmd = {
		"clangd",
		"--background-index",
		"--compile-commands-dir=build", -- specify compile_commands.json location if not in root
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		-- "--function-arg-placeholders",
		"--fallback-style=LLVM",
		"--all-scopes-completion", -- Show all possible completions
		"--cross-file-rename", -- Enable cross-file rename refactoring
		"--suggest-missing-includes",
		"--pch-storage=memory",
		"--header-insertion-decorators", --
		-- "--enable-config", -- Use .clangd config files
		-- "--log=error", -- Less noise, this
	},
	init_options = {
		-- usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
}

-- Toggle inlay hints
map("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

-- Conform.nvim - Formatting (replaces none-ls formatters)
require("conform").setup({
	formatters_by_ft = {
		-- Lua
		lua = { "stylua" },

		-- JavaScript/TypeScript/Web
		javascript = { "prettier" },
		typescript = { "prettier" },
		html = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },

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
		-- clang_format = {
		-- 	prepend_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 8, TabWidth: 8, UseTab: Always, ColumnLimit: 100}" },
		-- },
		clang_format = {
			-- Defer to the project's .clang-format file; fall back to LLVM if none exists.
			prepend_args = { "-style=file", "--fallback-style=LLVM" },
		},
		prettier = {
			extra_args = { "--print-width", "200" }, -- increase to prevent JSX wrapping
			prepend_args = { "--config-precedence", "prefer-file", "--tab-width", "4" },
		},
	},
})
-- 100 character line width for prettier which looks like:
----------------------------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)

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

-- require("vague").setup({ transparent = true })
-- vim.cmd("colorscheme catppuccin-macchiato")
-- vim.cmd("colorscheme tairiki-dimmed")
-- vim.cmd("colorscheme tokyonight-moon")

vim.cmd("colorscheme kanagawa-wave")
