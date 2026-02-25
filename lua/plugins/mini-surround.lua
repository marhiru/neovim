return {
    "echasnovski/mini.surround",
    lazy = true,
    config = function()
        require("mini.surround").setup({
            mappings = {
                add = "sa",
                delete = "sd",
                find = "sf",
                find_left = "sF",
                highlight = "sh",
                replace = "sr",
                update_n_lines = "sn",
            },
        })
    end,
    keys = {
        { "sa", desc = "Surround add" },
        { "sd", desc = "Surround delete" },
        { "sf", desc = "Surround find" },
        { "sF", desc = "Surround find left" },
        { "sh", desc = "Surround highlight" },
        { "sr", desc = "Surround replace" },
    },
}
