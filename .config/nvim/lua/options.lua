vim.g.have_nerd_font = true

-- basics
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.foldmethod = "syntax"
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cmdheight = 0
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = true
vim.opt.linebreak = true
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
vim.opt.clipboard:append("unnamedplus")

-- undo and backup
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.autoread = true
vim.opt.autowrite = false

-- visual
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.colorcolumn = "100"

-- behavior
vim.opt.backspace = "indent,eol,start"
vim.opt.iskeyword:append("-")
vim.opt.mouse = "a"
vim.opt.modifiable = true

vim.opt.virtualedit = "block"

vim.opt.title = true
vim.opt.titlestring = 'nvim: %{expand("%:t")}'
vim.opt.titleold = "zsh"

-- views can only be fully collapsed with the global statusline-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- cursor
vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
