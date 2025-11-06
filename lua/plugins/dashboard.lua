return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        math.randomseed(os.time())

        local onepiece = require("ascii.anime.onepiece")

        local chars = {}
        for k, v in pairs(onepiece) do
            if type(v) == "table" and type(v[1]) == "string" then
                chars[#chars + 1] = k
            end
        end

        -- pick a random character and header
        local key = chars[math.random(#chars)]
        local header = onepiece[key]

        local quotes = {
            luffy   = { "I’m gonna be King of the Pirates!" },
            zoro    = { "Nothing happened." },
            nami    = { "I’ll draw the map of the world." },
            sanji   = { "I love all women." },
            robin   = { "I want to live!" },
            chopper = { "I’m not a raccoon!" },
        }

        local function pick(t) return t[math.random(#t)] end
        local function Cap(s) return (s:gsub("^%l", string.upper)) end

        -- local footer_line = (quotes[key] and ("— " .. Cap(key) .. ": " .. pick(quotes[key]))) or ""
        local footer_line = (quotes[key] and (pick(quotes[key]))) or ""

        require("dashboard").setup({
            theme = "doom",
            config = {
                header = header,
                center = {
                    { icon = "  ", desc = "Find File", key = 'f', action = "Telescope find_files", shortcut = "SPC f f" },
                    { icon = "  ", desc = "Find Word", key = 'w', action = "Telescope live_grep", shortcut = "SPC f w" },
                    { icon = "  ", desc = "Recent Files", key = 'r', action = "Telescope oldfiles", shortcut = "SPC f r" },
                    { icon = "  ", desc = "Config", key = 'c', action = "edit ~/.config/nvim/init.lua", shortcut = "SPC f c" },
                    { icon = "  ", desc = "Quit", key = 'q', action = "qa", shortcut = "SPC q" },
                },
                footer = { footer_line },
            },
        })
    end,
}
