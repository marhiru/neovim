return {
    "goolord/alpha-nvim",
    opts = function(_, opts)
        local dashboard = require("alpha.themes.dashboard")

        vim.defer_fn(function()
            vim.cmd("AlphaRedraw")
        end, 200)

        -- Header
        dashboard.section.header.val = {
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀",
        }

        table.insert(
            dashboard.section.buttons.val,
            3, -- insert at position 3
            dashboard.button("p", "  Open Project", ":Telescope projects<CR>")
        )

        table.insert(dashboard.section.buttons.val, 4, dashboard.button("u", "  Update Plugins", ":Lazy sync<CR>"))

        -- Reassign the updated buttons back to opts
        opts.section.buttons.val = dashboard.section.buttons.val
        opts.layout = {
            { type = "padding", val = 2 },
            dashboard.section.header,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            { type = "padding", val = 2 },
            {
                type = "text",
                val = "💡 Tip: Press 'p' to open your last project!",
                opts = { hl = "AlphaFooter", position = "center" },
            },
            { type = "padding", val = 1 },
            dashboard.section.footer,
        }
    end,
}
