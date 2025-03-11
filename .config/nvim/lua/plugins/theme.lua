return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            on_highlights = function(hl, c)
                hl.LineNr = { fg = "white" }
                hl.CursorLineNr = { fg = "#ffffff", bold = true }
                hl.LineNrAbove = { fg = "lightgray" }
                hl.LineNrBelow = { fg = "lightgray" }
            end,
            on_colors = function(c)
                c.border = "lightgray"
            end,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        enabled = false,
        priority = 1000,
        opts = {
            contrast = "hard",
        },
        config = function(_, opts)
            require("gruvbox").setup(opts)
            vim.cmd.colorscheme("gruvbox")
            vim.api.nvim_set_hl(0, "LineNr", { fg = "lightgray" })
            vim.api.nvim_set_hl(0, "LspReferenceText", { fg = "lightblue" })
            vim.api.nvim_set_hl(0, "LspReferenceRead", { fg = "white" })
            vim.api.nvim_set_hl(0, "LspReferenceWrite", { fg = "lightred" })
        end,
    },
    {
        "catppuccin/nvim",
        enabled = false,
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha",
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            --vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
