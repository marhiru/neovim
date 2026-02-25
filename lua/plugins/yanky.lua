return {
    "gbprod/yanky.nvim",
    lazy = true,
    dependencies = { "folke/snacks.nvim" },
    config = function()
        require("yanky").setup({})
    end,
    keys = {
        {
            "<leader>p",
            function()
                require("snacks").picker.yanky()
            end,
            mode = { "n", "x" },
            desc = "Open Yank History",
        },
    },
}
