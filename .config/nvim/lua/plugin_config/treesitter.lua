return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local languages = {
				"c",
				"cpp",
				"rust",
				"lua",
				"javascript",
				"typescript",
				"markdown",
				"vimdoc",
				"vim",
				"python",
				"html",
				"yaml",
			}
			require("nvim-treesitter").install(languages)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "<filetype>" },
				callback = function(args)
					-- replicate `highlight = { enable = true }`
					vim.treesitter.start()

					-- replicate `indent = { enable = true }`
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				separator = "—",
			})
		end,
	},
}
