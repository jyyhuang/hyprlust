-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.diagnostic.config({
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		header = "",
		prefix = "",
	},
})

--Highlights on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Undotree
vim.keymap.set("n", "<Leader>ut", vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })

-- Move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move 1 line down (visual mode)" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move 1 line up (visual mode)" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Move next line to end of current line (normal mode)" })

-- Panel Movement
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { silent = true, desc = "Switch to left panel" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { silent = true, desc = "Switch to bottom panel" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { silent = true, desc = "Switch to top panel" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { silent = true, desc = "Switch to right panel" })

-- Paste preserve
vim.keymap.set("x", "<Leader>p", '"_dP', { desc = "Preserve paste" })

--Replace
vim.keymap.set("n", "<Leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace all words" })
vim.keymap.set(
	{ "n", "v" },
	"<Leader>ar",
	":,$s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "Replace all words after current line" }
)

-- yazi
vim.keymap.set("n", "-", function()
	require("yazi").yazi()
end, { desc = "Open yazi" })

-- highlight search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove highlight" })

-- Resize windows
vim.keymap.set("n", "<C-Up>", "<cmd>resize +5<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -5<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -5<cr>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +5<cr>", { desc = "Decrease Window Width" })
