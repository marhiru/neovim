return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.config").setup({
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
            },
        })
    end


}
