-- Options for neolive
vim.opt.shiftwidth = 4
vim.o.guifont = "JetBrainsMono Nerd Font:h14:w8"

vim.opt.ttimeoutlen = 100

-- Clipboard with fallback (for neovide/Linux without clipboard tools)
local function has_clipboard()
    local ok, is_wsl = pcall(vim.fn.has, "wsl")
    if ok and is_wsl == 1 then return true end
    if vim.fn.executable("wl-copy") == 1 then return true end
    if vim.fn.executable("xclip") == 1 then return true end
    return false
end
if has_clipboard() then
    vim.opt.clipboard = "unnamedplus"
end

vim.o.signcolumn = "no"
vim.opt.termguicolors = true
vim.opt.list = false
