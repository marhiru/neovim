return {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
        global_keymaps = true,
    },
    config = function(_, opts)
        require("kulala").setup(opts)
        require("config.ws").setup()
    end,
}
