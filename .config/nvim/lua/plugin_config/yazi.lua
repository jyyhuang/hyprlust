return {
	"mikavilpas/yazi.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	opts = {
		-- if you want to open yazi instead of netrw, see below for more info
		open_for_directories = false,
		floating_window_scaling_factor = 1,
		yazi_floating_window_border = "none",
	},
	config = function()
		vim.keymap.set("n", "-", "<cmd>Yazi<cr>", { desc = "Open yazi" })
	end,
}
