local function cmd()
    local path = vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer"

    if vim.fn.executable(path) == 1 then
        return { path }
    end

    return { "rust-analyzer" }
end

return {
    name = "rust-analyzer",
    cmd = cmd(),
    root_dir = vim.fs.root(0, { "Cargo.toml", "Cargo.lock", ".git" }),
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    ft = "rs",
    settings = {
        rust_analyzer = {
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
            },
            checkOnSave = {
                command = "clippy", -- or "check"
                extraArgs = { "--", "-W", "clippy::all" },
            },
            procMacro = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                experimental = { enable = true },
            },
            inlayHints = {
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                parameterHints = { enable = true },
                typeHints = { enable = true },
            },
        },
    },
}
