return {
	{
		"neovim/nvim-lspconfig",
	},
	{
		"mason-org/mason.nvim",
		lazy = false,
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp",
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")

			-- enable mason and configure icons
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			mason_lspconfig.setup()

			mason_tool_installer.setup({
				ensure_installed = {
					-- Tools
					"stylua",
					"black",
					"isort",
					"prettierd",
					"prettier",
					"eslint_d",

					--Lsp
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"marksman",
				},
			})

			-- Define sign icons for each severity
			local signs = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = "󰠠 ",
				[vim.diagnostic.severity.INFO] = " ",
			}

			-- Set diagnostic config
			vim.diagnostic.config({
				signs = {
					text = signs,
				},
				virtual_text = true,
				underline = true,
				update_in_insert = false,
			})

			-- NOTE: LSP Keybinds
			-- LSP keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc, silent = true })
					end

					map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
					map("]d", vim.diagnostic.goto_next, "Next diagnostic")

					map("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")

					map("<leader>d", vim.diagnostic.open_float, "Show line diagnostics")

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					map("gt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					map("H", vim.lsp.buf.hover, "Hover Documentation")
				end,
			})
		end,
	},
}
