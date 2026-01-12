-- basics
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cmdheight = 0
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = true
vim.opt.scrolloff = 999
vim.opt.inccommand = "split"

-- identation
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Sync system clipboard with Neovim clipboard
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.opt.undofile = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- visual
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- behavior
vim.opt.iskeyword:append("-")
vim.opt.mouse = "a"

vim.opt.virtualedit = "block"

vim.opt.title = true
vim.opt.titlestring = "%t"
vim.opt.titleold = "zsh"

vim.opt.winborder = "rounded"

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	update_in_insert = false,
})
