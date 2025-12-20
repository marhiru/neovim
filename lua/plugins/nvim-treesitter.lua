return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        { " nvim-treesitter/nvim-treesitter-textobjects" }
    },
    config = function()
        local configs = require("nvim-treesitter.config")

        configs.setup({
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
            },
            highlight = {
                enable = true
            },
        })
    end


}
