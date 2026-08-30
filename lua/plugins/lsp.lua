return {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
        { "mason-org/mason.nvim" },
        { "neovim/nvim-lspconfig" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim" },
        { "jay-babu/mason-nvim-dap.nvim" },
        { "jay-babu/mason-null-ls.nvim" },
        { "nvimtools/none-ls.nvim" },
    },
    config = function()
        local attach = function(client, bufnr)
            local bufmap = function(keys, func)
                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "" })
            end

            bufmap("gd", vim.lsp.buf.definition)
            bufmap("gD", vim.lsp.buf.declaration)
            bufmap("gr", vim.lsp.buf.references)
            bufmap("gI", vim.lsp.buf.implementation)
            bufmap("K", vim.lsp.buf.hover)
            bufmap("<leader>ca", vim.lsp.buf.code_action)
            bufmap("<leader>cr", vim.lsp.buf.rename)

            bufmap("gs", function()
                vim.cmd("vsplit")
                vim.lsp.buf.definition()
            end)
            bufmap("gx", function()
                vim.cmd("split")
                vim.lsp.buf.definition()
            end)
        end

        require("mason-null-ls").setup({
            ensure_installed = {
                -- formatters handled by lua/plugins/null-ls.lua
            },
        })
        require("mason-nvim-dap").setup({})
        require("mason-tool-installer").setup({
            ensure_installed = {
                "vtsls",
                "vls",
                "ruff",
                "pyright",
                "clangd",
                "ols",
                "lua_ls",
                "vue_ls",
                "zls",
                "gopls",
                "stylua",
                "elp",
            },
            integrations = {
                ["mason-lspconfig"] = true,
                ["mason-null-ls"] = true,
                ["mason-nvim-dap"] = true,
            },
        })
        require("mason").setup({})
        require("mason-lspconfig").setup({
            automatic_enable = {
                "vtsls",
                "vls",
                "ocamllsp",
                "ols",
                "ruff",
                "pyright",
                "clangd",
                "lua_ls",
                "vue_ls",
                "zls",
                "gopls",
                "stylua",
                "expert",
                "elp",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        cmd = { server_name },
                        on_attach = attach,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    })
                end,
                lua_ls = function()
                    local config_path = vim.fn.stdpath("config")

                    require("lspconfig").lua_ls.setup({
                        on_attach = attach,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),

                        root_dir = function(fname)
                            if not fname or fname == "" then
                                return nil
                            end
                            if
                                not fname:match("^" .. vim.pesc(config_path))
                            then
                                return nil
                            end
                            return require("lspconfig.util").root_pattern(
                                ".luarc.json",
                                ".git"
                            )(fname) or config_path
                        end,

                        -- Settings declared upfront, no on_init needed
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                    pathStrict = false,
                                },
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    library = {
                                        vim.env.VIMRUNTIME,
                                        config_path,
                                        config_path .. "/lua",
                                    },
                                    checkThirdParty = false,
                                    ignoreDir = { ".git", "node_modules" },
                                },
                                telemetry = { enable = false },
                            },
                        },
                    })
                end,
                vtsls = function()
                    vim.lsp.start({
                        name = "vtsls",
                        cmd = { "vtsls", "--stdio" },
                        root_dir = vim.fs.root(0, {
                            "package.json",
                            "tsconfig.json",
                            "vite.config.ts",
                            ".git",
                        }),
                        on_attach = function(client, bufnr)
                            client.server_capabilities.documentFormattingProvider =
                                false
                            client.server_capabilities.documentRangeFormattingProvider =
                                false
                            client.offset_encoding = "utf-16"
                            vim.keymap.set(
                                "n",
                                "gd",
                                vim.lsp.buf.definition,
                                { buffer = bufnr, desc = "Goto Definition" }
                            )
                            vim.keymap.set(
                                "n",
                                "gr",
                                vim.lsp.buf.references,
                                { buffer = bufnr, desc = "References" }
                            )
                            vim.keymap.set(
                                "n",
                                "K",
                                vim.lsp.buf.hover,
                                { buffer = bufnr, desc = "Hover" }
                            )
                            vim.keymap.set(
                                "n",
                                "<leader>ca",
                                vim.lsp.buf.code_action,
                                { buffer = bufnr, desc = "Code Action" }
                            )
                            vim.keymap.set(
                                "n",
                                "gI",
                                vim.lsp.buf.implementation,
                                { buffer = bufnr, desc = "Goto Implementation" }
                            )
                        end,
                        settings = {
                            vtsls = {
                                complete = {
                                    enable = true,
                                    includeAutoCompletions = true,
                                    includeSnippetPlaceholders = true,
                                },
                                goToSourceDefinition = { enable = true },
                                hybridTags = { enable = true },
                            },
                            typescript = {
                                inlayHints = {
                                    includeInlayParameterNameHints = "all",
                                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayVariableTypeHints = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                    includeInlayEnumMemberValueHints = true,
                                },
                            },
                            javascript = {
                                inlayHints = {
                                    includeInlayParameterNameHints = "all",
                                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayVariableTypeHints = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                    includeInlayEnumMemberValueHints = true,
                                },
                            },
                        },
                        capabilities = {
                            textDocument = {
                                foldingRange = { dynamicRegistrations = false },
                                semanticTokens = {
                                    dynamicRegistrations = false,
                                },
                            },
                        },
                        flags = {
                            debounce_text_changes = 0,
                            exit_timeout = 0,
                            allow_incremental_sync = true,
                        },
                    })
                    return true
                end,
                pyright = function()
                    local python_path = vim.fn.expand(".venv/bin/python")
                    if not vim.fn.filereadable(python_path) then
                        python_path = vim.fn.exepath("python3")
                            or vim.fn.exepath("python")
                    end
                    require("lspconfig").pyright.setup({
                        on_attach = function(client, bufnr)
                            attach(client, bufnr)
                            client.server_capabilities.documentFormattingProvider =
                                false
                            client.server_capabilities.documentRangeFormattingProvider =
                                false
                        end,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        settings = {
                            pyright = { disableOrganizeImports = true },
                            python = {
                                analysis = {
                                    diagnosticMode = "openFilesOnly",
                                    typeCheckingMode = "basic",
                                    useLibraryCodeForTypes = true,
                                },
                                pythonPath = python_path,
                            },
                        },
                    })
                end,
                ruff = function()
                    local python_path = vim.fn.expand(".venv/bin/python")
                    if not vim.fn.filereadable(python_path) then
                        python_path = vim.fn.exepath("python3")
                            or vim.fn.exepath("python")
                    end
                    require("lspconfig").ruff.setup({
                        on_attach = function(client, bufnr)
                            attach(client, bufnr)
                            client.server_capabilities.documentFormattingProvider =
                                false
                            client.server_capabilities.documentRangeFormattingProvider =
                                false
                        end,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        init_options = {
                            settings = {
                                interpreter = python_path,
                                lint = {
                                    enable = true,
                                    select = { "E", "F", "I", "F841" },
                                    ignore = {},
                                },
                                format = { enable = true },
                            },
                        },
                    })
                end,
                zls = function()
                    require("lspconfig").zls.setup({
                        cmd = "/usr/bin/zls",
                        settings = {
                            zls = {
                                -- https://zigtools.org/zls/guides/build-on-save/
                                semantic_tokens = "partial",
                                zig_exe_path = "/usr/bin/zig",
                            },
                        },
                    })
                end,
                ocamllsp = function()
                    require("lspconfig").ocamllsp.setup({
                        cmd = { "ocamllsp" },
                        on_attach = attach,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    })
                end,
                vls = function()
                    require("lspconfig").vls.setup({
                        cmd = { "vls" },
                        on_attach = attach,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    })
                end,
            },
        })
    end,
}
