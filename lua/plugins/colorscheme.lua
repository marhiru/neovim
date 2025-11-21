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
            require("black-metal").setup({})
            -- vim.cmd("colorscheme bathory")
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
            require("nord").setup()
        end
    },
    {
    'scozu/karasu',
    lazy = false,
    priority = 1000,
    config = function()
        require('karasu').setup()
    end
    },
    -- {
    --     "sainnhe/sonokai",
    --     name = "sonokai",
    --     config = function()
    --         vim.g.sonokai_style = "andromeda"
    --         vim.g.sonokai_enable_italic = 1
    --         vim.g.sonokai_transparent_background = 0
    --         vim.g.sonokai_better_performance = 1
    --
    --         -- vim.cmd.colorscheme("sonokai")
    --         --
    --         local custom_bg = "#0f0f10"
    --
    --         vim.api.nvim_set_hl(0, "Normal", { bg = custom_bg })
    --         vim.api.nvim_set_hl(0, "NormalNC", { bg = custom_bg })
    --         vim.api.nvim_set_hl(0, "SignColumn", { bg = custom_bg })
    --         vim.api.nvim_set_hl(0, "LineNr", { bg = custom_bg })
    --         vim.api.nvim_set_hl(0, "FoldColumn", { bg = custom_bg })
    --         vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = custom_bg })
    --         vim.api.nvim_set_hl(0, "CursorLine", { bg = "#141414" })
    --     end,
    -- }
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "karasu",
        },
    },
}
