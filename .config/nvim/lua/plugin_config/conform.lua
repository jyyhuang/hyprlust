return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort" },
					javascript = { "prettier" },
					tyepescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
				},
			})

			vim.keymap.set({ "n", "v" }, "<Leader>mp", function()
				conform.format({ async = false, lsp_fallback = true, timeout_ms = 500 })
			end, { desc = "Format" })
		end,
	},
}
