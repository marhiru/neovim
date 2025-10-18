return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim" },
        { "neovim/nvim-lspconfig" },
    },
    config = function()
        require("mason").setup({})
        require("mason-lspconfig").setup({
            automatic_enable = {
                "ts_ls",
                "rust-analyzer",
                "ols",
                "ruff_lsp", -- Primary for linting/formatting
                "pyright",  -- Type checking
                "zls",
                "clangd",
                "lua_ls",
            },
            ensure_installed = {
                "ts_ls",
                "ruff_lsp",
                "pyright",
                -- ruff is a dependency of ruff_lsp, no need to list separately
            },
            handlers = {
                -- Default handler
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        on_attach = attach, -- Your existing function
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    })
                end,
                -- Pyright: Type checking only
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
                -- Ruff LSP: Linting and formatting via LSP
                ruff_lsp = function()
                    require("lspconfig").ruff_lsp.setup({
                        on_attach = function(client, bufnr)
                            attach(client, bufnr)
                            -- Ensure formatting is enabled
                            client.server_capabilities.documentFormattingProvider = true
                            -- Test formatting to confirm
                            if client.server_capabilities.documentFormattingProvider then
                                vim.lsp.buf.format({ bufnr = bufnr, name = "ruff_lsp", timeout_ms = 500 })
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
            },
        })
    end,
}
