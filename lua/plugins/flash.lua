return {
    "folke/flash.nvim",
    lazy = true,
    config = function()
        require("flash").setup({
            search = {
                mode = "search",
            },
        })
    end,
    keys = {
        { "s", mode = { "n", "x", "o" }, desc = "Flash" },
        { "S", mode = { "n", "o", "x" }, desc = "Flash backwards" },
    },
}
