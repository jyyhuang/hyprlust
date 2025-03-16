return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    })

    vim.keymap.set("n", "<Leader>th", ":Gitsigns preview_hunk<CR>", {})
    vim.keymap.set("n", "<Leader>tb", ":Gitsigns toggle_current_line_blame<CR>", {})
  end,
}
