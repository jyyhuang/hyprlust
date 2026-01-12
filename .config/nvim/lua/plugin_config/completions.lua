return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
    event = {"InsertEnter", "CmdwinEnter"},

		version = "1.*",

		opts = {
			keymap = {
				preset = "default",

				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "select_and_accept", "fallback" },

				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				list = { selection = { preselect = false, auto_insert = true } },
				documentation = { auto_show = true, auto_show_delay_ms = 0 },
				menu = {
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description" },
							{ "kind" },
						},
						treesitter = {
							"lsp",
						},
					},
				},
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
}
