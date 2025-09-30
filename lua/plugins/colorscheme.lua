return {
    {
        "Shatur/neovim-ayu",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            require("ayu").setup({
                mirage = false,
            })
            vim.cmd("colorscheme ayu-dark")
        end,
    },
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
        name = "black-metal",
        config = function()
            require("black-metal").setup({})
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "black-metal",
        },
    },
}
