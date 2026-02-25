return {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").setup({
            defaults = {
                find_command = { "fzf" },
            },
        })
    end,
    keys = {
        { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    },
}
