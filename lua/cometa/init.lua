local util = require("cometa.util")
local theme = require("cometa.theme")

vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "cometa"

util.load(theme)
