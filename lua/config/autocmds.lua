-- Autocmds for neolive
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 200,
        })
    end,
})

-- Format on save helper (skips if triggered by keymap)
local function format_on_save(patterns)
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = patterns,
        callback = function()
            if vim.b.skip_autoformat then
                return
            end
            vim.lsp.buf.format({ async = true })
        end,
    })
end

-- Register format on save for supported file types
format_on_save({ "*.lua" })    -- stylua
format_on_save({ "*.py" })     -- ruff
format_on_save({ "*.js", "*.ts", "*.jsx", "*.tsx", "*.vue", "*.svelte" }) -- prettier
format_on_save({ "*.zig", "*.zon" }) -- zls
