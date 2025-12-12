-- require("wrapping").setup({
-- 	auto_set_mode_filetype_allowlist = {
-- 		"markdown",
-- 		"text",
-- 		"tex",
-- 		"plaintex",
-- 		"asciidoc",
-- 	},
-- })

-- require("wrapping").setup({
-- 	softener = { markdown = true }, -- always soft wrap markdown
-- 	auto_set_mode_filetype_allowlist = {
-- 		"markdown",
-- 		"text",
-- 		"asciidoc",
-- 	},
-- })

require("wrapping").setup({
	set_nvim_opt_defaults = true, -- use soft wrap defaults
	softener = { markdown = true },
})
