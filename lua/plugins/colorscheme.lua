return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_italics = true,
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
        -- priority = 1000,
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
        end
    },
    -- {
    --     'scozu/karasu',
    --     lazy = false,
    --     config = function()
    --         require('karasu').setup({})
    --     end
    -- },
    {
        "IroncladDev/osmium",
        lazy = false,
        config = function()
            require("osmium").setup({})
        end,
    },
    {
        "zenbones-theme/zenbones.nvim",
        dependencies = "rktjmp/lush.nvim",
        lazy = false,
        config = function()
            require("zenbones").setup({})
        end
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "osmium",
        },
    },
}
