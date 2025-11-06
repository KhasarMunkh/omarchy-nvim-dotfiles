-- ~/.config/nvim/after/ftplugin/gdscript.lua

-- 1) Connect to Godot’s LSP
local port = tonumber(os.getenv("GDScript_Port")) or 6005
local cmd = vim.lsp.rpc.connect("127.0.0.1", port)

-- 2) Start a Neovim RPC server for Godot to talk to (only once)
local pipe = "/tmp/godot.nvim"  -- or (os.getenv("XDG_RUNTIME_DIR") or "/tmp") .. "/godot.nvim"

-- If Neovim isn't already listening on this address, start it
local ok = pcall(function()
  -- serverlist() returns a list of addresses (pipes/sockets) Neovim is serving
  local servers = vim.fn.serverlist()
  local already = false
  for _, s in ipairs(servers) do
    if s == pipe then already = true; break end
  end
  if not already then
    vim.fn.serverstart(pipe)
  end
end)
-- (No need to error if it fails; Godot can still launch nvim fine.)

-- 3) Fire up the LSP client
vim.lsp.start({
  name = "Godot",
  cmd = cmd,
  root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
})

vim.keymap.set("n", "<leader>K", function()
  local sym = vim.fn.expand("<cword>")
  vim.fn.jobstart({ "xdg-open",
    "https://docs.godotengine.org/en/stable/classes/class_" .. sym:lower() .. ".html"
  }, { detach = true })
end, { buffer = true, desc = "Open Godot docs for symbol" })
