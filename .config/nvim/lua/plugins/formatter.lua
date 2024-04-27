return {
    'stevearc/conform.nvim',
    event = "BufEnter",
    opts = {
        formatters_by_ft = {
            sql = { "sql_formatter" },
            go = { "goimports" },
            lua = { "stylua" },
        },
        formatters = {
            sql_formatter = {
                args = { "-l", "postgresql" },
            },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
    keys = {
        { "<leader>cf", function() require('conform').format({ lsp_fallback = true }) end, desc = "Format file" },
    }
}
