return {
    {
        "vague-theme/vague.nvim",
        name = "vague",
        lazy = false,
        config = function()
            require("vague").setup({})
        end,
    },
    {
        "oskarnurm/koda.nvim",
        lazy = false,
        priority = 1000,
        name = "koda",
        config = function()
            require("koda").setup({
                cache = true,
                styles = {
                    functions = { bold = false },
                    keywords = { italic = true },
                    comments = {},
                    strings = {},
                    constants = {},
                },
                colors = {
                    type = "#aaadfa",
                    func = "#82a7bd",
                    keyword = "#98aaab",
                    const = "#aaadfa",
                    string = "#92b4fc",
                },
            })
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
        config = function()
            require("tairiki").setup({})
        end,
    },
    {
        "p00f/alabaster.nvim",
        lazy = false,
    },
    {
        "olivercederborg/poimandres.nvim",
        lazy = false,
    },
    {
        "ficcdaf/ashen.nvim",
        lazy = false,
    },
    {
        "metalelf0/black-metal-theme-neovim",
        lazy = false,
        name = "black-metal",
        config = function()
            require("black-metal").setup({})
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({})
        end,
        opts = {},
    },
    {
        "gbprod/nord.nvim",
        name = "nord",
        opts = {},
        config = function()
            require("nord").setup({})
        end,
    },
    {
        "IroncladDev/osmium",
        lazy = false,
        config = function()
            require("osmium").setup({})
        end,
    },
    {
        "cranberry-clockworks/coal.nvim",
        lazy = false,
    },
    {
        "topazape/oldtale.nvim",
        config = function()
            require("oldtale")
        end,
    },
}
