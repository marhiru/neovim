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
        "metalelf0/base16-black-metal-scheme",
        name = "base16-black-metal",
        config = function()
            require("base16-black-metal-scheme").setup({})
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "ayu-dark",
        },
    },
}
