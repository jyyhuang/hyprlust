return {
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true, -- Disable setting background
				},
				groups = {
					carbonfox = {
						Pmenu = { bg = "NONE" },
						PmenuThumb = { bg = "#8cb6ff" },
						BlinkCmpMenu = { bg = "NONE" },
						BlinkCmpMenuBorder = { link = "Title" },
						BlinkCmpMenuSelection = { link = "CursorLine" },

						BlinkCmpDoc = { bg = "NONE" },
						BlinkCmpDocBorder = { link = "Keyword" },
						NormalFloat = { bg = "NONE" },

						BlinkCmpSignatureHelp = { bg = "NONE" },
						BlinkCmpSignatureHelpBorder = { link = "Keyword" },
					},
				},
			})
			vim.cmd.colorscheme("carbonfox")
		end,
	},
}
