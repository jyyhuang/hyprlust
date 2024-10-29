return {
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true, -- Disable setting background
					terminal_colors = false,
				},
			})
			vim.cmd.colorscheme("carbonfox")
		end,
	},
}
