return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
        require("project_nvim").setup({
            detection_methods = { "pattern", "lsp" },
            patterns = { ".git", "package.json", "Makefile", "pyproject.toml", "Cargo.toml", "build.zig", "venv" },
            silent_chdir = true,
            show_hidden = true,
            exclude_dirs = {},
        })

        pcall(require("fzf-lua").load_extension, "projects")
    end,
}
