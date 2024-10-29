return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
          enable = true,
        },
        additional_vim_regex_highlighting = false,

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Leader>ss",
            node_incremental = "<Leader>sd",
            scope_incremental = "<Leader>sw",
            node_decremental = "<Leader>sa",
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
}
