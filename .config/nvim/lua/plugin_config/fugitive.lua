return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gg", "<cmd>tabnew | Git | only<cr>", { desc = "Fugitive full page" })
		vim.keymap.set("n", "<leader>ds", "<cmd>Gvdiffsplit<CR>", { desc = "Fugitive diff split" })
	end,
}
