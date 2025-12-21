return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "vue",
                "typescript",
                "javascript",
                "html",
                "css",
                "json",
                "zig",
                "json",
                "c",
                "cpp",
                "c3",
                "julia",
                "rust",
                "python",
                "haskell",
                "go",
                "elixir",
                "eex",
                "heex",
            },
            highlight = {
                enable = true
            },
            indent = {
                enable = true,
            }
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "elixir", "heex", "eex" },
            callback = function(ev)
                vim.treesitter.start(ev.buf)
            end
        })
    end


}
