local config_path = vim.fn.stdpath("config")

return {
    ft = "lua",
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                    config_path,
                    config_path .. "/lua",
                },
                checkThirdParty = false,
            },
            codeLens = { enable = true },
            hint = { enable = true, semicolon = "Disable" },
            telemetry = { enable = false },
        },
    },
}
