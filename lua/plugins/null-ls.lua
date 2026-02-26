return {
    "nvimtools/none-ls.nvim",
    lazy = true,
    config = function()
        local null_ls = require("null-ls")

        local function has_formatter(name)
            local ok, builtin = pcall(function()
                return null_ls.builtins.formatting[name]
            end)
            return ok and builtin ~= nil
        end

        local sources = {}
        local errors = {}

        if has_formatter("stylua") then
            local stylua_path = vim.fn.stdpath("config") .. "/stylua.toml"
            table.insert(sources, null_ls.builtins.formatting.stylua.with({
                extra_args = { "--config-path", stylua_path }
            }))
        else
            table.insert(errors, "stylua not found")
        end

        if has_formatter("prettier") then
            table.insert(sources, null_ls.builtins.formatting.prettier.with({}))
        else
            table.insert(errors, "prettier not found")
        end

        if has_formatter("ruff") then
            table.insert(sources, null_ls.builtins.formatting.ruff.with({
                extra_args = { "--fix" },
            }))
        else
            table.insert(errors, "ruff not found")
        end

        if #errors > 0 then
            vim.notify("null-ls: " .. table.concat(errors, ", "), vim.log.levels.WARN)
        end

        null_ls.setup({ sources = sources })
    end,
}
