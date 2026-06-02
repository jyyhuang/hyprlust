-- basics
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 999
vim.opt.inccommand = "split"

-- identation
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Sync system clipboard with Neovim clipboard
vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")

-- undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- visual
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- behavior
vim.opt.laststatus = 3
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
	update_in_insert = true,
})

vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess:append("c")
