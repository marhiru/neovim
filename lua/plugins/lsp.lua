return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim" },
        {
            "neovim/nvim-lspconfig",
        },
    },
    config = function()
        require("mason").setup({})
        require("mason-lspconfig").setup({
            automatic_enable = {
                "ts_ls",
                "rust-analyzer",
                "ols",
                "ruff_lsp", -- Handles Python diagnostics and formatting
                "zls",
                "clangd",
                "lua_ls",
                exclude = {
                    "pyright", -- Keep Pyright excluded
                },
            },
            ensure_installed = {
                "ts_ls",
                "ruff_lsp", -- Ensure Ruff is installed
            },
            automatic_installation = { exclude = { "pyright" } }, -- Extra safety
            handlers = {
                -- Default handler for most servers
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        on_attach = function(client, bufnr)
                            -- Call your existing attach function
                            attach(client, bufnr)
                            -- Add formatting command only for servers that support it
                            if client.server_capabilities.documentFormattingProvider then
                                vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                                    vim.lsp.buf.format({ bufnr = bufnr })
                                end, { desc = "Format current buffer with LSP" })
                            end
                        end,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(), -- For nvim-cmp
                    })
                end,
                -- Explicit Ruff handler for formatting
                ruff_lsp = function()
                    require("lspconfig").ruff_lsp.setup({
                        on_attach = function(client, bufnr)
                            attach(client, bufnr)
                            -- Ensure Ruff can format
                            client.server_capabilities.documentFormattingProvider = true
                            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end, { desc = "Format current buffer with Ruff" })
                            -- Optional: Auto-format on save
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = bufnr,
                                callback = function()
                                    vim.lsp.buf.format({ bufnr = bufnr })
                                end,
                            })
                        end,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        settings = {
                            args = { "--line-length=88" }, -- Customize Ruff
                        },
                    })
                end,
            },
        })
    end,
}
