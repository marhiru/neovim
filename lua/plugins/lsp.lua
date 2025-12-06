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
                "ruff",
                "pyright",
                "vue-language-server",
                "zls"
            },
            automatic_enable = {
                "vtsls",
                "rust-analyzer",
                "ols",
                "ruff",
                "pyright",
                "clangd",
                "lua_ls",
                "ruff",
                "pyright",
                "vue-language-server",
                "zls"
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
                vtsls = function()
                    require("lspconfig").vtsls.setup({
                        on_attach = function(client, bufnr)
                            attach(client, bufnr)
                            -- When in a .vue file the token highlight will be disabled
                            if vim.bo.filetype == "vue" then
                                if client.server_capabilities.semanticTokensProvider then
                                    client.server_capabilities.semanticTokensProvider = nil
                                end
                            end
                        end
                    })
                end,
                vue_ls = function()
                    require("lspconfig").vue_ls.setup({
                        cmd = "~/.local/share/nvim/mason/bin/vue-language-server",
                        on_attach = function(client, bufnr)
                            attach(client, bufnr)
                            if vim.bo.filetype == "vue" then
                                if client.server_capabilities.semanticTokensProvider then
                                    client.server_capabilities.semanticTokensProvider = nil
                                end
                            end
                        end,
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
                                disableOrganizeImports = true,
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
                    local python_path = vim.fn.expand(".venv/bin/python")
                    if not vim.fn.filereadable(python_path) then
                        python_path = vim.fn.exepath("python3") or vim.fn.exepath("python")
                    end
                    require("lspconfig").ruff.setup({
                        on_attach = function(client, bufnr)
                            attach(client, bufnr)
                            client.server_capabilities.documentFormattingProvider = true
                            if client.server_capabilities.documentFormattingProvider then
                                vim.lsp.buf.format({ bufnr = bufnr, name = "ruff", timeout_ms = 200 })
                            end
                        end,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        init_options = {
                            settings = {
                                interpreter = python_path,
                                lint = {
                                    enable = true,
                                    select = { "E", "F", "I", "F841" },
                                    ignore = {}
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
