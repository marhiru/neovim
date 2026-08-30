return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
            follow_current_file = { enabled = true },
            -- hijack_netrw_behavior = "open_current",
            -- use_libuv_file_watcher = true,
        },
        window = {
            position = "current",
            width = 35,
        },
        default_component_configs = {
            indent = {
                with_expanders = true,
                expander_collapsed = "",
                expander_expanded = "",
            },
        },
    },
    config = function()
        require("neo-tree").setup({})
    end,
    keys = {
        {
            "<leader>e",
            "<cmd>Neotree toggle reveal position=current<CR>",
            desc = "Explorer (current window)",
        },
        {
            "<leader>E",
            "<cmd>Neotree reveal position=current<CR>",
            desc = "Explorer Reveal (current window)",
        },
    },
}
