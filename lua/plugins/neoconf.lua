return {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    lazy = true,
    config = function()
        require("neoconf").setup({})
    end,
}
