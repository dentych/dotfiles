return {
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
            { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete other buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete buffers to the right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete buffers to the left" },
            { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
            { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
            { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
            { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
        },
        event = "VimEnter",
        opts = {
            options = {
                -- stylua: ignore
                close_command = function(n) require("mini.bufremove").delete(n, false) end,
                -- stylua: ignore
                right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
                always_show_bufferline = true,
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "center",
                    },
                },
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd("BufAdd", {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
            })
        end,
    },
    -- noice for cmdline, notifications and stuff
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- there are multiple plugins handling signature help. Disable noice's version here (I'm not sure which plugin does the handling now :D)
            lsp = {
                signature = {
                    enabled = false,
                },
            },
        },
        keys = {
            { "<S-Enter>",  function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c",                 desc = "Redirect Cmdline" },
            { "<leader>nl", function() require("noice").cmd("last") end,                   desc = "Noice Last Message" },
            { "<leader>nh", function() require("noice").cmd("history") end,                desc = "Noice History" },
            { "<leader>na", function() require("noice").cmd("all") end,                    desc = "Noice All" },
            { "<leader>nd", function() require("noice").cmd("dismiss") end,                desc = "Dismiss All" },
        }
    }
}
