return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim" },
        { "neovim/nvim-lspconfig" },
    },
    config = function()
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "vtsls",
                "rust-analyzer",
                "ols",
                "ruff",
                "pyright",
                "clangd",
                "lua_ls",
                "vtsls",
                "ruff",
                "pyright",
            },
            automatic_enable = {
                "vtsls",
                "rust-analyzer",
                "ols",
                "ruff",
                "pyright",
                "clangd",
                "lua_ls",
                "vtsls",
                "ruff",
                "pyright",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        on_attach = attach,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    })
                    vim.api.nvim_create_augroup("BufWritePre", {
                        pattern = { "*.zig", "*.zon" },
                        callback = function()
                            vim.lsp.buf.format()
                        end
                    })
                end,
                pyright = function()
                    local python_path = vim.fn.expand(".venv/bin/python")
                    if not vim.fn.filereadable(python_path) then
                        python_path = vim.fn.exepath("python3") or vim.fn.exepath("python")
                    end
                    require("lspconfig").pyright.setup({
                        on_attach = function(client, bufnr)
                            attach(client, bufnr)
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentRangeFormattingProvider = false
                        end,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        settings = {
                            pyright = {
                                disableOrganizeImports = true, -- Let ruff_lsp handle imports
                            },
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
                    require("lspconfig").ruff.setup({
                        on_attach = function(client, bufnr)
                            attach(client, bufnr)
                            client.server_capabilities.documentFormattingProvider = true
                            if client.server_capabilities.documentFormattingProvider then
                                vim.lsp.buf.format({ bufnr = bufnr, name = "ruff", timeout_ms = 500 })
                            end
                        end,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        init_options = {
                            settings = {
                                lint = {
                                    enable = true,
                                    select = { "E", "F", "I" }, -- Include import lints
                                },
                                format = {
                                    enable = true,
                                },
                            },
                        },
                        })
                end,
                zls = function()
                    require("lspconfig").zls.setup {
                        cmd = "/usr/bin/zls",
                        settings = {
                            zls = {
                                -- https://zigtools.org/zls/guides/build-on-save/
                                semantic_tokens = "partial",
                                zig_exe_path = "/usr/bin/zig"
                            }
                        }
                    }
                end,
            },
        })
    end,
}
