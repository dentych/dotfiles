return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, c)
        hl.Comment = {
          fg = "#aaaaaa",
        }
        hl.LineNrAbove = {
          fg = "lightgray",
        }
        hl.LineNrBelow = hl.LineNrAbove
      end,
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
              ["<Tab>"] = { "list_down", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<S-Tab>"] = { "list_up", mode = { "i", "x" } },
              ["<Tab>"] = { "list_down", mode = { "i", "x" } },
            },
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
      },
    },
  },
}
