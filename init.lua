-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.shiftwidth = 4
vim.o.guifont = "JetBrainsMono Nerd Font:h14:w8"
vim.opt.clipboard = "unnamedplus"
vim.cmd("TransparencyToggle")
vim.o.signcolumn = "no"
vim.opt.termguicolors = true


------------
-- MACROS --
------------

local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa:" .. esc .. "la, " .. esc .. "pl")
