return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
		config = function()
			require("ibl").setup({
				indent = {
					char = "»",
					smart_indent_cap = false,
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
