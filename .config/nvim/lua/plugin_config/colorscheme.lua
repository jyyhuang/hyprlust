return {
  {
    "folke/tokyonight.nvim",

    name = "tokyonight",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        terminal_colors = true,
        hide_inactive_statusline = false,
        dim_inactive = true,
        lualine_bold = true,
      })

      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
