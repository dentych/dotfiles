return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters.sqlfluff = nil

      opts.formatters_by_ft.sql = { "sql_formatter" }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.sql = nil
    end,
  },
}
