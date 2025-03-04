return {
    {
        "olimorris/codecompanion.nvim",
        enabled = function()
            -- Only check for ANTHROPIC_API_KEY if NVIM_ENV is not "work"
            local should_disable = vim.env.NVIM_ENV ~= "work" and not vim.env.ANTHROPIC_API_KEY

            if should_disable then
                require("noice").notify(
                    "CodeCompanion is disabled. Please set ANTHROPIC_API_KEY environment variable.",
                    vim.log.levels.WARN
                )
                return false
            end
            return true
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "folke/noice.nvim",
        },
        opts = {
            strategies = {
                chat = {
                    adapter = vim.env.NVIM_ENV == "work" and "copilot" or "anthropic",
                    keymaps = {
                        close = {
                            modes = { n = "<C-c>", i = "<C-q>" },
                        },
                    },
                },
                inline = {
                    adapter = vim.env.NVIM_ENV == "work" and "copilot" or "anthropic",
                },
            },
            display = {
                diff = {
                    provider = "mini_diff",
                },
            },
        },
        keys = {
            {
                "<Space>cc",
                "<cmd>CodeCompanionChat<cr>",
                desc = "Code Companion Chat",
            },
        },
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = { "InsertEnter", "LspAttach" },
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
}
