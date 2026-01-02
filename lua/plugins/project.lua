return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
        require("project_nvim").setup({
            detection_methods = { "pattern", "lsp" },
            patterns = {
                ".git",
                -- Js/Ts Projects
                "package.json",
                -- C/C++ projects
                "Makefile",
                -- UV in python
                "pyproject.toml",
                -- Rust or rust-based projects
                "Cargo.toml",
                -- Zig projects
                "build.zig",
                -- Python projects
                "venv",
                -- Elixir projects
                "mix.exs",
                -- Golang projects
                "go.mod"
            },
            silent_chdir = true,
            show_hidden = true,
            exclude_dirs = {},
        })

        pcall(require("fzf-lua").load_extension, "projects")
    end,
}
