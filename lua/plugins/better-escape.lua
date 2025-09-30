return {
    {
        "LazyVim/LazyVim",
        opts = function(_, opts)
            local function has_lsp_client(bufnr)
                bufnr = bufnr or vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr })
                return clients and next(clients) ~= nil
            end

            vim.keymap.set("i", "kj", function()
                -- sair do insert
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)

                --- salvar
                vim.cmd("w")

                -- formatar se houver LSP
                if has_lsp_client(0) then
                    vim.lsp.buf.format({
                        async = true,
                        bufnr = 0,
                        callback = function()
                            vim.cmd("w")
                        end,
                    })
                else
                    if pcall(vim.cmd, "Neoformat") then
                        vim.cmd("w")
                    end
                end
            end, { noremap = true, silent = true, desc = "Escape + Save + Format" })
        end,
    },
}
