-- Keymaps for neolive
local map = vim.keymap.set

vim.opt.timeoutlen = 125

map("i", "kj", function()
    vim.cmd("stopinsert")
    vim.b.skip_autoformat = true
    vim.lsp.buf.format({ async = true })
    vim.cmd("write")
    vim.schedule(function()
        vim.b.skip_autoformat = false
    end)
end, { noremap = true, silent = true, desc = "Escape + Save + Format" })

-- Save and format
map({ "n", "i" }, "<C-s>", function()
    vim.cmd("stopinsert")
    vim.b.skip_autoformat = true
    vim.lsp.buf.format({ async = true })
    vim.cmd("write")
    vim.schedule(function()
        vim.b.skip_autoformat = false
    end)
end, { noremap = true, silent = true, desc = "Save and format" })

-- Telescope live_grep mapped to <Space>m
map("n", "<leader>m", function()
    require("telescope.builtin").live_grep()
end, { desc = "Search text (live_grep)" })

-- Flash keymaps
map("n", "<leader>cw", function()
    local word = vim.fn.expand("<cword>")
    require("flash").jump({
        search = { mode = "search", pattern = word },
        action = function(m)
            vim.api.nvim_win_set_cursor(0, { m.pos[1], m.pos[2] })
            vim.cmd("normal! ciw")
        end,
    })
end, { desc = "Change word via Flash" })

map("n", "<leader>gd", function()
    require("flash").jump({
        search = { mode = "search" },
        action = function(m)
            vim.api.nvim_win_set_cursor(0, { m.pos[1], m.pos[2] })
            vim.lsp.buf.definition()
        end,
    })
end, { desc = "Flash to definition" })

map("n", "<leader>rw", function()
    local word = vim.fn.expand("<cword>")
    local flash = require("flash")
    local function replace_next()
        flash.jump({
            search = { mode = "search", pattern = word },
            action = function(m)
                vim.api.nvim_win_set_cursor(0, { m.pos[1], m.pos[2] })
                vim.cmd("normal! ciw")
                vim.schedule(replace_next)
            end,
        })
    end
    replace_next()
end, { desc = "Sequential replace via Flash" })

-- LazyVim Keymaps (ported from LazyVim)
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
    vim.cmd("bd")
end, { desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Clear search on escape
map({ "i", "n", "s" }, "<esc>", function()
    vim.cmd("noh")
    return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Redraw / Clear hlsearch / Diff Update
map(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- Better n/N search behavior
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- Better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Location list
map("n", "<leader>xl", function()
    local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
    if not success and err then
        vim.notify(err, vim.log.levels.ERROR)
    end
end, { desc = "Location List" })

-- Quickfix list
map("n", "<leader>xq", function()
    local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
    if not success and err then
        vim.notify(err, vim.log.levels.ERROR)
    end
end, { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Diagnostic keymaps
local diagnostic_goto = function(next, severity)
    return function()
        vim.diagnostic.jump({
            count = (next and 1 or -1) * vim.v.count1,
            severity = severity and vim.diagnostic.severity[severity] or nil,
            float = true,
        })
    end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Toggle options (basic versions without Snacks)
map("n", "<leader>us", function()
    vim.opt.spell = not vim.opt.spell
    vim.notify(vim.opt.spell and "Spell enabled" or "Spell disabled")
end, { desc = "Toggle Spelling" })

map("n", "<leader>uw", function()
    vim.opt.wrap = not vim.opt.wrap
    vim.notify(vim.opt.wrap and "Wrap enabled" or "Wrap disabled")
end, { desc = "Toggle Wrap" })

map("n", "<leader>uL", function()
    vim.opt.relativenumber = not vim.opt.relativenumber
    vim.notify(vim.opt.relativenumber and "Relative numbers enabled" or "Relative numbers disabled")
end, { desc = "Toggle Relative Number" })

map("n", "<leader>ul", function()
    vim.opt.number = not vim.opt.number
    vim.notify(vim.opt.number and "Line numbers enabled" or "Line numbers disabled")
end, { desc = "Toggle Line Number" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Highlights under cursor
map("n", "<leader>i", vim.show_pos, { desc = "Inspect Pos" })

-- Windows
map("n", "<leader>wq", "<cmd>close!<cr>", { desc = "Close Window (Keep Buffer)" })
map("n", "<leader>w", "<cmd>split<cr>", { desc = "Horizontal Split" })
map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- Tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- LSP keymaps (using vim.lsp.buf)
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "Goto References" })
map("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>c", vim.lsp.buf.code_action, { desc = "Source Action" })

-- Git (if lazygit is available)
if vim.fn.executable("lazygit") == 1 then
    map("n", "<leader>gg", function()
        vim.cmd("!lazygit")
    end, { desc = "Lazygit" })
end

-- Project.nvim
map("n", "<leader>fp", function()
    vim.cmd("Telescope projects")
end, { desc = "Open Project" })

-- Colorscheme switching
local themes = {
    { name = "rose-pine", display = "Rose Pine" },
    { name = "vague", display = "Vague" },
    { name = "oldworld", display = "Oldworld" },
    { name = "tairiki", display = "Tairiki" },
    { name = "alabaster", display = "Alabaster" },
    { name = "poimandres", display = "Poimandres" },
    { name = "ashen", display = "Ashen" },
    { name = "black-metal", display = "Black Metal" },
    { name = "gruvbox", display = "Gruvbox" },
    { name = "nord", display = "Nord" },
    { name = "osmium", display = "Osium" },
    { name = "coal", display = "Coal" },
    { name = "oldtale", display = "Oldtale" },
}

map("n", "<leader>uC", function()
    local items = {}
    for _, theme in ipairs(themes) do
        table.insert(items, theme.display)
    end
    vim.ui.select(items, { prompt = "Choose colorscheme:" }, function(choice)
        if choice then
            for _, theme in ipairs(themes) do
                if theme.display == choice then
                    vim.cmd.colorscheme(theme.name)
                    vim.notify("Colorscheme: " .. theme.display, vim.log.levels.INFO)
                    break
                end
            end
        end
    end)
end, { desc = "Switch Colorscheme" })

-- Cycle colorschemes
local current_theme_index = 1
map("n", "<leader>u]", function()
    current_theme_index = current_theme_index % #themes + 1
    vim.cmd.colorscheme(themes[current_theme_index].name)
    vim.notify("Colorscheme: " .. themes[current_theme_index].display, vim.log.levels.INFO)
end, { desc = "Next Colorscheme" })

map("n", "<leader>u[", function()
    current_theme_index = current_theme_index - 1
    if current_theme_index < 1 then
        current_theme_index = #themes
    end
    vim.cmd.colorscheme(themes[current_theme_index].name)
    vim.notify("Colorscheme: " .. themes[current_theme_index].display, vim.log.levels.INFO)
end, { desc = "Previous Colorscheme" })

-- Terminal
map("t", "<esc>", "<c-\\><c-n>")

-- Horizontal terminal
map("n", "<leader>wt", function()
    vim.cmd.new()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 12)
    vim.wo.winfixheight = true
    vim.cmd.term()
end)

-- Vertical terminal
map("n", "<leader>wt", function()
    vim.cmd.new()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 12)
    vim.wo.winfixheight = true
    vim.cmd.term()
end)

map("n", "<leader>q", "<cmd>bd!<cr>", { desc = "Delete Buffer" })
