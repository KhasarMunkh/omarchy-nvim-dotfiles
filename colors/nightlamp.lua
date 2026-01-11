-- Nightlamp colorscheme (ported from NvChad base46)
-- Usage: :colorscheme nightlamp

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "nightlamp"

local c = {
  -- Base16 colors
  bg = "#18191f",
  bg1 = "#222329",
  bg2 = "#2c2d33",
  bg3 = "#3c3d43",
  bg4 = "#48494f",
  fg = "#b8af9e",
  fg1 = "#cbc0ab",
  fg2 = "#e0d6bd",

  purple = "#b8aad9",
  orange = "#cd9672",
  yellow = "#ccb89c",
  green = "#8aa387",
  teal = "#7aacaa",
  red = "#b58385",
  blue = "#8e9cb4",
  cyan = "#90a0a0",

  -- Extra colors
  dark_purple = "#a99bca",
  baby_pink = "#d6b3bd",
  pink = "#c99aa7",
  vibrant_green = "#94ad91",
  nord_blue = "#8d9bb3",
  sun = "#deb88a",
  line = "#313238",
  statusline_bg = "#1d1e24",
  lightbg = "#2b2c32",
}

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor highlights
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg1 })
hi("FloatBorder", { fg = c.blue, bg = c.bg1 })
hi("Cursor", { fg = c.bg, bg = c.fg })
hi("CursorLine", { bg = c.bg1 })
hi("CursorColumn", { bg = c.bg1 })
hi("LineNr", { fg = c.bg4 })
hi("CursorLineNr", { fg = c.yellow })
hi("SignColumn", { bg = c.bg })
hi("ColorColumn", { bg = c.bg1 })
hi("VertSplit", { fg = c.line })
hi("WinSeparator", { fg = c.line })
hi("StatusLine", { fg = c.fg, bg = c.statusline_bg })
hi("StatusLineNC", { fg = c.bg4, bg = c.statusline_bg })
hi("Pmenu", { fg = c.fg, bg = c.bg1 })
hi("PmenuSel", { fg = c.bg, bg = c.red })
hi("PmenuSbar", { bg = c.bg2 })
hi("PmenuThumb", { bg = c.bg4 })
hi("TabLine", { fg = c.fg, bg = c.bg1 })
hi("TabLineFill", { bg = c.bg })
hi("TabLineSel", { fg = c.fg2, bg = c.bg })
hi("Visual", { bg = c.bg3 })
hi("VisualNOS", { bg = c.bg3 })
hi("Search", { fg = c.bg, bg = c.yellow })
hi("IncSearch", { fg = c.bg, bg = c.orange })
hi("CurSearch", { fg = c.bg, bg = c.orange })
hi("MatchParen", { fg = c.orange, bold = true })
hi("Folded", { fg = c.bg4, bg = c.bg1 })
hi("FoldColumn", { fg = c.bg4, bg = c.bg })
hi("NonText", { fg = c.bg3 })
hi("SpecialKey", { fg = c.bg3 })
hi("Whitespace", { fg = c.bg3 })
hi("EndOfBuffer", { fg = c.bg })
hi("Directory", { fg = c.cyan })
hi("Question", { fg = c.green })
hi("MoreMsg", { fg = c.green })
hi("ModeMsg", { fg = c.green })
hi("ErrorMsg", { fg = c.red })
hi("WarningMsg", { fg = c.orange })
hi("WildMenu", { fg = c.bg, bg = c.blue })
hi("Title", { fg = c.purple, bold = true })
hi("Conceal", { fg = c.bg4 })
hi("SpellBad", { undercurl = true, sp = c.red })
hi("SpellCap", { undercurl = true, sp = c.yellow })
hi("SpellRare", { undercurl = true, sp = c.purple })
hi("SpellLocal", { undercurl = true, sp = c.cyan })
hi("DiffAdd", { bg = "#2a3d2c" })
hi("DiffChange", { bg = "#3d3d2a" })
hi("DiffDelete", { fg = c.red, bg = "#3d2a2a" })
hi("DiffText", { bg = "#4d4d2a" })

-- Syntax highlights
hi("Comment", { fg = c.bg4, italic = true })
hi("Constant", { fg = c.orange })
hi("String", { fg = c.green })
hi("Character", { fg = c.green })
hi("Number", { fg = c.orange })
hi("Boolean", { fg = c.orange })
hi("Float", { fg = c.orange })
hi("Identifier", { fg = c.fg })
hi("Function", { fg = c.blue })
hi("Statement", { fg = c.purple })
hi("Conditional", { fg = c.purple })
hi("Repeat", { fg = c.purple })
hi("Label", { fg = c.purple })
hi("Operator", { fg = c.fg })
hi("Keyword", { fg = c.purple })
hi("Exception", { fg = c.purple })
hi("PreProc", { fg = c.teal })
hi("Include", { fg = c.purple })
hi("Define", { fg = c.purple })
hi("Macro", { fg = c.teal })
hi("PreCondit", { fg = c.teal })
hi("Type", { fg = c.yellow })
hi("StorageClass", { fg = c.yellow })
hi("Structure", { fg = c.yellow })
hi("Typedef", { fg = c.yellow })
hi("Special", { fg = c.teal })
hi("SpecialChar", { fg = c.teal })
hi("Tag", { fg = c.red })
hi("Delimiter", { fg = c.fg })
hi("SpecialComment", { fg = c.bg4 })
hi("Debug", { fg = c.red })
hi("Underlined", { underline = true })
hi("Error", { fg = c.red })
hi("Todo", { fg = c.yellow, bold = true })

-- Treesitter highlights
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.red })
hi("@variable.parameter", { fg = c.fg1 })
hi("@variable.member", { fg = c.cyan })
hi("@constant", { fg = c.orange })
hi("@constant.builtin", { fg = c.orange })
hi("@module", { fg = c.teal })
hi("@label", { fg = c.purple })
hi("@string", { fg = c.green })
hi("@string.escape", { fg = c.teal })
hi("@string.regex", { fg = c.teal })
hi("@character", { fg = c.green })
hi("@number", { fg = c.orange })
hi("@boolean", { fg = c.orange })
hi("@float", { fg = c.orange })
hi("@function", { fg = c.blue })
hi("@function.builtin", { fg = c.teal })
hi("@function.call", { fg = c.blue })
hi("@function.macro", { fg = c.teal })
hi("@method", { fg = c.blue })
hi("@method.call", { fg = c.blue })
hi("@constructor", { fg = c.teal })
hi("@keyword", { fg = c.purple })
hi("@keyword.function", { fg = c.purple })
hi("@keyword.operator", { fg = c.purple })
hi("@keyword.return", { fg = c.purple })
hi("@conditional", { fg = c.purple })
hi("@repeat", { fg = c.purple })
hi("@exception", { fg = c.purple })
hi("@include", { fg = c.purple })
hi("@type", { fg = c.yellow })
hi("@type.builtin", { fg = c.yellow })
hi("@type.definition", { fg = c.yellow })
hi("@type.qualifier", { fg = c.purple })
hi("@attribute", { fg = c.teal })
hi("@property", { fg = c.cyan })
hi("@field", { fg = c.cyan })
hi("@parameter", { fg = c.fg1 })
hi("@punctuation.delimiter", { fg = c.fg })
hi("@punctuation.bracket", { fg = c.fg })
hi("@punctuation.special", { fg = c.teal })
hi("@comment", { fg = c.bg4, italic = true })
hi("@operator", { fg = c.fg })
hi("@tag", { fg = c.red })
hi("@tag.attribute", { fg = c.yellow })
hi("@tag.delimiter", { fg = c.fg })

-- LSP highlights
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.orange })
hi("DiagnosticInfo", { fg = c.blue })
hi("DiagnosticHint", { fg = c.teal })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.orange })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = c.teal })
hi("LspReferenceText", { bg = c.bg2 })
hi("LspReferenceRead", { bg = c.bg2 })
hi("LspReferenceWrite", { bg = c.bg2 })
hi("LspSignatureActiveParameter", { fg = c.orange, bold = true })

-- Git signs
hi("GitSignsAdd", { fg = c.green })
hi("GitSignsChange", { fg = c.yellow })
hi("GitSignsDelete", { fg = c.red })

-- Telescope
hi("TelescopeBorder", { fg = c.blue })
hi("TelescopePromptBorder", { fg = c.blue })
hi("TelescopeResultsBorder", { fg = c.blue })
hi("TelescopePreviewBorder", { fg = c.blue })
hi("TelescopeSelection", { bg = c.bg2 })
hi("TelescopeMatching", { fg = c.orange, bold = true })

-- Nvim-tree / Oil
hi("NvimTreeNormal", { fg = c.fg, bg = c.bg })
hi("NvimTreeFolderIcon", { fg = c.cyan })
hi("NvimTreeFolderName", { fg = c.cyan })
hi("NvimTreeOpenedFolderName", { fg = c.cyan })
hi("OilDir", { fg = c.cyan })
hi("OilFile", { fg = c.fg })

-- Indent blankline
hi("IblIndent", { fg = c.bg2 })
hi("IblScope", { fg = c.bg4 })

-- Cmp
hi("CmpItemAbbr", { fg = c.fg })
hi("CmpItemAbbrMatch", { fg = c.blue, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = c.blue })
hi("CmpItemKind", { fg = c.purple })
hi("CmpItemMenu", { fg = c.bg4 })

-- Lazy
hi("LazyH1", { fg = c.bg, bg = c.purple })
hi("LazyButton", { bg = c.bg2 })
hi("LazyButtonActive", { bg = c.bg3 })

-- Which-key
hi("WhichKey", { fg = c.purple })
hi("WhichKeyGroup", { fg = c.teal })
hi("WhichKeyDesc", { fg = c.fg })
hi("WhichKeySeparator", { fg = c.bg4 })
