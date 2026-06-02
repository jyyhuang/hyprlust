return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		event = "VeryLazy",
		dependencies = { "nvim-mini/mini.icons" },
		config = function()
			local fzf_lua = require("fzf-lua")

			fzf_lua.setup({
				winopts = {
					fullscreen = true,
				},
				files = {
					fzf_opts = {
						["--exact"] = "",
					},
				},
			})
			vim.keymap.set("n", "<leader>sf", fzf_lua.files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sg", fzf_lua.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sk", fzf_lua.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sh", fzf_lua.helptags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sd", fzf_lua.diagnostics_workspace, { desc = "[S]earch [D]iagnostics" })
		end,
	},
}
