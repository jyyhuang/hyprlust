-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
		map("]d", vim.diagnostic.goto_next, "Next diagnostic")

		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

		map("H", vim.lsp.buf.hover, "Hover Documentation")

		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	end,
})

vim.diagnostic.config({
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
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

-- None ls
vim.keymap.set({ "n", "v" }, "<Leader>mp", vim.lsp.buf.format, { desc = "Format" })

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
