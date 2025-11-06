-- lua/plugins/colors.lua
return {
  -- 1) Inline color previews (incl. Tailwind classes)
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      filetypes = {
        "css", "scss", "html",
        "javascript", "typescript",
        "javascriptreact", "typescriptreact",
        "svelte",
      },
      user_default_options = {
        names = false,        -- keep this off if you find it noisy
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        rgb_fn = true,        -- rgb(), rgba()
        hsl_fn = true,        -- hsl()
        tailwind = true,      -- 👈 enable Tailwind color boxes
        mode = "virtualtext", -- "background" is heavier; VT is lighter
      },
    },
  },

  -- 2) Tailwind colors in completion menu (requires nvim-cmp)
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = true, -- just needs default cfg
  },

  -- 3) Smarter Tailwind doc colors + utilities
  {
    "luckasRanarison/tailwind-tools.nvim",
    ft = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      document_color = {
        enabled = true,
        kind = "virtualtext", -- inline (virt text) is nice; "foreground" also works
      },
    },
  },
}
