-- ~/.config/neolive/init.lua
-- Basic Neovim init for neolive config
-- Uses LazyVim only as package manager (no lazyvim.plugins)

vim.opt.runtimepath:prepend(vim.fn.stdpath("config"))

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

require("lsp")

-- Basic settings
local leader = ","
vim.g.mapleader = leader
vim.g.maplocalleader = leader

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")

-- Set colorscheme (find theme with used = true)
local function load_used_colorscheme()
    local ok, spec = pcall(require, "plugins.colorscheme")
    if not ok then
        vim.cmd.colorscheme("koda")
        return
    end

    local theme_name = "koda" -- default
    for _, theme in ipairs(spec) do
        if theme.used then
            theme_name = theme.name or theme[1]:match("/([^/]+)$")
            break
        end
    end

    vim.cmd.colorscheme(theme_name)
end

load_used_colorscheme()
