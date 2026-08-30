return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
        require("project_nvim").setup({
            detection_methods = { "pattern", "lsp" },
            patterns = {
                ".git",
                "package.json",
                "Makefile",
                "pyproject.toml",
                "Cargo.toml",
                "build.zig",
                "venv",
                "mix.exs",
                "go.mod",
            },
            show_hidden = true,
            -- silent_chdir = true,
            -- exclude_dirs = {},
        })

        pcall(require("fzf-lua").load_extension, "projects")
    end,
}
