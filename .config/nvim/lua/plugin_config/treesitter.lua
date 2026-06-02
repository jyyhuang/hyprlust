return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		config = function()
			local languages = {
				--languages
				"rust",
				"typescript",
				"javascript",
				"tsx",
				"html",
				"css",
				"json",
				"bash",
				"python",

				--extras
				"dockerfile",
			}
			require("nvim-treesitter").install(languages)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(args)
					local buf = args.buf
					local filetype = vim.bo[buf].filetype

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					local ok_add = pcall(vim.treesitter.language.add, language)

					if not ok_add then
						return
					end

					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

					pcall(vim.treesitter.start, buf, language)
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
