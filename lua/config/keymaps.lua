-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map({ "n", "i" }, "<C-s>", function()
    vim.cmd("stopinsert")
    vim.cmd("write")
    -- require("conform").format({ async = true, lsp_fallback = true })
end, { noremap = true, silent = true, desc = "Save and format" })

-- Telescope live_grep mapped to <Space>m
vim.keymap.set("n", "<leader>m", function()
    require("telescope.builtin").live_grep()
end, { desc = "Search text (live_grep)" })

vim.keymap.set("n", "<leader>cw", function()
    local word = vim.fn.expand("<cword>")
    require("flash").jump({
        search = { mode = "search", pattern = word },
        action = function(m)
            vim.api.nvim_win_set_cursor(0, { m.pos[1], m.pos[2] })
            vim.cmd("normal! ciw")
        end,
    })
end, { desc = "Change word via Flash" })

vim.keymap.set("n", "<leader>gd", function()
    require("flash").jump({
        search = { mode = "search" },
        action = function(m)
            vim.api.nvim_win_set_cursor(0, { m.pos[1], m.pos[2] })
            vim.cmd("lua vim.lsp.buf.definition()")
        end,
    })
end, { desc = "Flash to definition" })

vim.keymap.set("n", "<leader>rw", function()
    local word = vim.fn.expand("<cword>")
    local flash = require("flash")
    local function replace_next()
        flash.jump({
            search = { mode = "search", pattern = word },
            action = function(m)
                vim.api.nvim_win_set_cursor(0, { m.pos[1], m.pos[2] })
                vim.cmd("normal! ciw")
                vim.schedule(replace_next) -- reopen after each change
            end,
        })
    end
    replace_next()
end, { desc = "Sequential replace via Flash" })
