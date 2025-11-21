return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
        require("project_nvim").setup({
            -- 📁 Your configuration options
            detection_methods = { "pattern", "lsp" },
            patterns = { ".git", "package.json", "Makefile", "pyproject.toml", "Cargo.toml", "build.zig" },
            silent_chdir = true,
            show_hidden = false,
            exclude_dirs = {},
        })

        -- Optional integration with telescope
        pcall(require("telescope").load_extension, "projects")
    end,
}
