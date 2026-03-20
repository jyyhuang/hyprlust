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

			vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep, { desc = "[S]earch by [G]rep" })
		end,
	},
}
