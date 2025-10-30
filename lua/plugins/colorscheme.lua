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
        "vague-theme/vague.nvim",
        lazy = false,
        name = "vague",
        config = function()
            require("vague").setup({})
        end,
    },
    {
        "dgox16/oldworld.nvim",
        name = "oldworld",
        lazy = false,
        config = function()
            require("oldworld").setup({})
        end,
    },
    {
        "deparr/tairiki.nvim",
        lazy = false,
    },
    {
        "p00f/alabaster.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "ficcdaf/ashen.nvim",
        lazy = false
    },
    {
        "metalelf0/black-metal-theme-neovim",
        lazy = false,
        name = "black-metal",
        config = function()
            require("black-metal").setup({
                theme = "immortal",
                variant = "dark",
                alt_bg = false,
            })
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        config = true,
        opts = {},
    },
    {
        "gbprod/nord.nvim",
        name = "nord",
        opts = {},
        config = function()
            require("nord").setup()
            -- require("nord").load()
        end
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "alabaster",
        },
    },
}
