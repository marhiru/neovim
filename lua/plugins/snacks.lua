return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("snacks").setup({
            picker = {
                sources = {
                    files = {
                        hidden = false,
                    },
                },
            },
            explorer = {
                files = {
                    hidden = false,
                },
            },
            scroll = { enabled = false },
            indent = { enabled = false }
        })
    end,
}
