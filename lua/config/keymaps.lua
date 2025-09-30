-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map({ "n", "i" }, "<C-s>", function()
    vim.cmd("stopinsert")
    vim.cmd("write")
    require("conform").format({ async = true, lsp_fallback = true })
end, { noremap = true, silent = true, desc = "Save and format" })
