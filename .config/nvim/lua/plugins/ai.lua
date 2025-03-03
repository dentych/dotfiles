return {
    {
        "olimorris/codecompanion.nvim",
        enabled = function()
            -- Only check for ANTHROPIC_API_KEY if NVIM_ENV is not "work"
            local should_disable = vim.env.NVIM_ENV ~= "work" and not vim.env.ANTHROPIC_API_KEY

            if should_disable then
                vim.api.nvim_create_autocmd("VimEnter", {
                    callback = function()
                        vim.notify(
                            "CodeCompanion is disabled. Please set ANTHROPIC_API_KEY environment variable.",
                            vim.log.levels.WARN
                        )
                    end,
                    once = true,
                })
                return false
            end
            return true
        end,
        config = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            strategies = {
                chat = {
                    adapter = vim.env.NVIM_ENV == "work" and "copilot" or "anthropic",
                    keymaps = {
                        close = {
                            modes = { n = "q", i = "<C-q>" },
                        },
                    },
                },
                inline = {
                    adapter = vim.env.NVIM_ENV == "work" and "copilot" or "anthropic",
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
