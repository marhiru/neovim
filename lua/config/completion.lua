vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local cmp_nvim_lsp = require("cmp_nvim_lsp")
vim.lsp.config("*", { capabilities = cmp_nvim_lsp.default_capabilities() })

local lspkind = require("lspkind")
lspkind.init({})

local cmp = require("cmp")

cmp.setup({
    enabled = function()
        return vim.api.nvim_get_option_value("buftype", { buf = 0 })  ~= "prompt" 
    end,
    performance = {
        debounce = 30,
        fetching = 30,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 900 },
        { name = "path", priority = 700 },
    }, {
        { name = "buffer", priority = 500 },
    }),
    mapping = cmp.mapping({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-x>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                require("luasnip").jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = {
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                path = "[Path]",
                buffer = "[Buf]",
            },
        }),
    },
})

local ls = require("luasnip")
ls.config.set_config({
    history = false,
    updateevents = "TextChanged,TextChangedI",
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
    loadfile(ft_path)()
end

vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })
