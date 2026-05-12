-- Options for neolive
vim.opt.shiftwidth = 4
vim.o.guifont = "JetBrainsMono Nerd Font:h14:w8"

vim.opt.ttimeoutlen = 100

-- Clipboard with fallback (for neovide/Linux without clipboard tools)
local function has_clipboard()
	local ok, is_wsl = pcall(vim.fn.has, "wsl")
	if ok and is_wsl == 1 then
		return true
	end
	if vim.fn.executable("wl-copy") == 1 then
		return true
	end
	if vim.fn.executable("xclip") == 1 then
		return true
	end
	return false
end
if has_clipboard() then
	vim.opt.clipboard = "unnamedplus"
end

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

local indent_settings = {
	typescript = { tabstop = 4, shiftwidth = 4, expandtab = true },
	typescriptreact = { tabstop = 4, shiftwidth = 4, expandtab = true },
	javascript = { tabstop = 4, shiftwidth = 4, expandtab = true },
	javascriptreact = { tabstop = 4, shiftwidth = 4, expandtab = true },
	lua = { tabstop = 4, shiftwidth = 4, expandtab = true },
	json = { tabstop = 4, shiftwidth = 4, expandtab = true },
	yaml = { tabstop = 4, shiftwidth = 4, expandtab = true },
	html = { tabstop = 4, shiftwidth = 4, expandtab = true },
	css = { tabstop = 4, shiftwidth = 4, expandtab = true },
	python = { tabstop = 4, shiftwidth = 4, expandtab = true },
	rust = { tabstop = 4, shiftwidth = 4, expandtab = true },
	go = { tabstop = 4, shiftwidth = 4, expandtab = false },
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.tbl_keys(indent_settings),
	callback = function(ev)
		local s = indent_settings[vim.bo[ev.buf].filetype]
		if not s then
			return
		end
		vim.opt_local.tabstop = s.tabstop
		vim.opt_local.shiftwidth = s.shiftwidth
		vim.opt_local.softtabstop = s.shiftwidth
		vim.opt_local.expandtab = s.expandtab
	end,
})

vim.o.signcolumn = "no"
vim.opt.termguicolors = true
vim.opt.list = false
