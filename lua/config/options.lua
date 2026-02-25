-- Options for neolive
vim.opt.shiftwidth = 4
vim.o.guifont = "JetBrainsMono Nerd Font:h14:w8"

-- Clipboard with fallback (for neovide/Linux without clipboard tools)
if vim.fn.has("wsl") == 1 or vim.fn.executable("wl-copy") == 1 or vim.fn.executable("xclip") == 1 then
    vim.opt.clipboard = "unnamedplus"
end

vim.o.signcolumn = "no"
vim.opt.termguicolors = true
vim.opt.list = false
