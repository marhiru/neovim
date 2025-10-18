-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.lsp.inlay_hint.enable(false, nil)

------------
-- MACROS --
------------

local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa:" .. esc .. "la, " .. esc .. "pl")
