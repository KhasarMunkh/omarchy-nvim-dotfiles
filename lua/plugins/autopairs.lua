-- ~/.config/nvim/lua//plugins/autopairs.lua
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- load when you enter Insert mode
  opts  = {
    check_ts = true,     -- smarter pairing via treesitter
    fast_wrap = {},      -- <Alt-e> → wrap existing word in brackets/quotes
  },
}
