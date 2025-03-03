return {
    "stevearc/conform.nvim",
    event = "BufEnter",
    opts = {
        formatters_by_ft = {
            sql = { "sql_formatter" },
            go = { "goimports-reviser", "goimports", stop_after_first = true },
            lua = { "stylua" },
            graphql = { "prettierd" },
            proto = { "buf" },
            json = { "prettierd" },
            html = { "prettierd" },
            js = { "prettierd" },
            yaml = { "prettierd" },
        },
        formatters = {
            sql_formatter = {
                args = { "-l", "postgresql" },
            },
            goimports = {
                inherit = false,
                command = "goimports",
            },
            ["goimports-reviser"] = {
                prepend_args = { "-rm-unused" },
            },
        },
        format_on_save = {
            timeout_ms = 1000,
            lsp_format = "fallback",
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        log_level = vim.log.levels.DEBUG,
    },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format()
            end,
            desc = "Format file",
        },
    },
}
