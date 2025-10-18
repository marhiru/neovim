return {
    "nvim-telescope/telescope.nvim",
    opts = {
        defaults = {
            find_command = { "fd", "--type", "--hidden", "--exclude", ".git" },
        },
    },
}
