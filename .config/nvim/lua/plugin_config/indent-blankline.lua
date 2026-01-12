return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
				indent = {
					char = "»",
					tab_char = "»",
					highlight = { "Whitespace" },
				},
				scope = {
					show_start = false,
					show_end = false,
					highlight = { "Boolean" },
					include = {
						node_type = { ["*"] = { "*" } },
					},
				},
			})
		end,
	},
}
