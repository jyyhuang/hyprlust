return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night",
			transparent = true,
			on_highlights = function(hl, c)
				hl.FloatBorder = { fg = c.blue2, bg = "NONE" }
			end,
		})
		vim.cmd("colorscheme tokyonight")
	end,
}
