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

        local function get_formatter_opts()
            local tabstop = vim.opt.tabstop:get()
            local shiftwidth = vim.opt.shiftwidth:get()
            local expandtab = vim.opt.expandtab:get()
            return { tabstop = tabstop, shiftwidth = shiftwidth, expandtab = expandtab }
        end

        if has_formatter("stylua") then
            local stylua_path = vim.fn.stdpath("config") .. "/stylua.toml"
            table.insert(sources, null_ls.builtins.formatting.stylua.with({
                extra_args = { "--config-path", stylua_path },
            }))
        else
            table.insert(errors, "stylua not found")
        end

        if has_formatter("prettier") then
            table.insert(sources, null_ls.builtins.formatting.prettier.with({
                extra_args = function(args)
                    local opts = get_formatter_opts()
                    local result = {}
                    for _, v in ipairs(args or {}) do
                        table.insert(result, v)
                    end
                    table.insert(result, "--tab-width=" .. opts.tabstop)
                    if not opts.expandtab then
                        table.insert(result, "--use-tabs")
                    end
                    return result
                end,
            }))
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

        if has_formatter("ocamlformat") then
            table.insert(sources, null_ls.builtins.formatting.ocamlformat.with({}))
        else
            table.insert(errors, "ocamlformat not found")
        end

        if has_formatter("clang_format") then
            table.insert(sources, null_ls.builtins.formatting.clang_format.with({
                extra_args = function(args)
                    local opts = get_formatter_opts()
                    return {
                        "-style={BasedOnStyle: llvm, IndentWidth: "
                            .. opts.shiftwidth
                            .. ", UseTab: "
                            .. (opts.expandtab and "Never" or "Always")
                            .. "}",
                    }
                end,
            }))
        else
            table.insert(errors, "clang_format not found")
        end

        if #errors > 0 then
            vim.notify("null-ls: " .. table.concat(errors, ", "), vim.log.levels.WARN)
        end

        null_ls.setup({ sources = sources })
    end,
}