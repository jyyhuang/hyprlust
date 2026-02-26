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
					javascript = { "prettierd" },
					tyepescript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescriptreact = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					markdown = { "prettierd" },
          cpp = {"clang-format"},
          c = {"clang-format"}
				},
			})

			vim.keymap.set({ "n", "v" }, "<Leader>mp", function()
				conform.format({ async = false, lsp_fallback = true, timeout_ms = 500 })
			end, { desc = "Format" })
		end,
	},
}
