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
        priority = 1000,
        config = function()
            require("vague").setup({})
        end,
    },

    -- {
    --     "dgox16/oldworld.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd([[colorscheme oldworld]])
    --     end,
    -- },
    -- {
    --     "chrsm/paramount-ng.nvim",
    --     dependencies = {
    --         "rktjmp/lush.nvim",
    --     },
    --     priority = 1000,
    --     config = function()
    --         vim.cmd([[colorscheme paramount-ng]])
    --         vim.api.nvim_set_hl(0, "Normal", { bg = "#0f0f17" })
    --         vim.api.nvim_set_hl(0, "NormalFlo;at", { bg = "#0f0f17" })
    --         vim.api.nvim_set_hl(0, "NormalNC", { bg = "#0f0f17" })
    --     end,
    -- },
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
            require("black-metal").load()
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        config = true,
        opts = {},
    },
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "oh-lucy",
    --     },
    -- },
}
