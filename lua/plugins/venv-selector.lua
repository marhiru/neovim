return {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    event = "VeryLazy",
    config = function()
        require("venv-selector").setup({
            auto_enable = true,
            search_venv_managers = true, -- Poetry/pipenv
            search_workspace = true,     -- Look for .venv
            path = ".",                  -- Project root
        })
    end,
}
