return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {},
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>e",
            function()
                pcall(require("neo-tree").setup({}))
            end,
            mode = { "n", "x" },
            desc = "Expĺorer (current dir)"
        }
    },
    lazy = false,
    config = function()
        require("neo-tree").setup({
            window = {
                position = "current"
            }
        })
    end
}
