return {
    "nvim-mini/mini.nvim",
    lazy = true,
    config = function()
        require("mini.nvim").setup({})
        require("mini.bufremove").setup({})
    end,
}