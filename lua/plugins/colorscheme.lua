return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_italics = true,
                disable_float_background = true,
                highlight_groups = {
                    Delimiter = { fg = "iris" },
                    Normal = { bg = "#090413" },
                    NormalNC = { bg = "#090413" },
                },
            })
        end,
    },
    {
        "metalelf0/black-metal-theme-neovim",
<<<<<<< HEAD
        name = "black-metal",
        config = function()
            require("black-metal").setup({})
=======
        lazy = false,
        name = "black-metal",
        config = function()
            require("black-metal").setup({
                theme = "taake",
                variant = "dark",
                alt_bg = false,
            })
            require("black-metal").load()
>>>>>>> e2f0f1c932c1ef100eb7bceb8ad7ccfa48157d5f
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "black-metal",
        },
    },
}
