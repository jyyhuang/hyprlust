return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })
      local npairs = require("nvim-autopairs")

      npairs.setup({
        fast_wrap = {
          map = "<C-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = "$",
          before_key = "h",
          after_key = "l",
          cursor_pos_before = true,
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          manual_position = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          -- Defaults
          enable_close = true,      -- Auto close tags
          enable_rename = true,     -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
      })
    end,
  },
}
