return {
    "echasnovski/mini.files",
    lazy = true,
    cmd = { "MiniFiles" },
    version = false,
    config = function()
        require("mini.files").setup({})
    end,
}
