return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({})
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSP
					"pylsp",
					"ts_ls",
					"rust_analyzer",
					"lua_ls",
					"clangd",

					-- Others
					"black",
					"prettier",
					"stylua",
					"clang-format",
				},
			})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})
			vim.lsp.enable("qmlls")
			vim.lsp.config("qmlls", {
				cmd = { "qmlls6" },
			})

			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			})

			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, { desc = "Prev diagnostic" })

			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, { desc = "Next diagnostic" })

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })
			vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
			vim.keymap.set("n", "ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
		end,
	},
}
