return {
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function(_, config)
            require("mini.surround").setup()
            require("mini.pairs").setup()
            require("mini.comment").setup()
            require("mini.bufremove").setup()
            require("mini.ai").setup()
            require("mini.indentscope").setup()

            -- mini starter stuff
            local starter = require("mini.starter")
            -- close Lazy and re-open when starter is ready
            -- if vim.o.filetype == "lazy" then
            --     vim.cmd.close()
            --     vim.api.nvim_create_autocmd("User", {
            --         pattern = "MiniStarterOpened",
            --         callback = function()
            --             require("lazy").show()
            --         end,
            --     })
            -- end

            starter.setup({autoopen = false})

            vim.api.nvim_create_autocmd({ "VimEnter" }, {
                callback = function(ev)
                    vim.notify("inside the starter callback")
                    if vim.fn.argc() == 1 and vim.fn.argv(0) == "." then
                        -- open starter if nvim was started with `nvim .`
                        vim.notify("inside the if statement")
                        starter.open()
                        starter.refresh()
                    else
                        vim.notify("inside the else statement")
                    end
                end
            })
        end,
    },
}
