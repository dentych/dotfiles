return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        {
            "fredrikaverpil/neotest-golang",
            dependencies = {
                "leoluz/nvim-dap-go",
            },
        },
    },
    opts = {
        -- Can be a list of adapters like what neotest expects,
        -- or a list of adapter names,
        -- or a table of adapter names, mapped to adapter configs.
        -- The adapter will then be automatically loaded with the config.
        adapters = {
            ["neotest-golang"] = {
                go_test_args = { "-tags=integration" },
                testify_enabled = true,
            },
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
            open = function()
                require("trouble").open({ mode = "quickfix", focus = false })
            end,
        },
    },
    config = function(_, opts)
        local adapters = {}
        for name, config in pairs(opts.adapters) do
            table.insert(adapters, require(name)(config))
        end
        opts.adapters = adapters

        local neotest_ns = vim.api.nvim_create_namespace("neotest")
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    -- Replace newline and tab characters with space for more compact diagnostics
                    local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                    return message
                end,
            },
        }, neotest_ns)
        require("neotest").setup(opts)

        if require("util").has("trouble") then
            opts.consumers = opts.consumers or {}
            -- Refresh and auto close trouble after running tests
            ---@type neotest.Consumer
            opts.consumers.trouble = function(client)
                client.listeners.results = function(adapter_id, results, partial)
                    if partial then
                        return
                    end
                    local tree = assert(client:get_position(nil, { adapter = adapter_id }))

                    local failed = 0
                    for pos_id, result in pairs(results) do
                        if result.status == "failed" and tree:get_key(pos_id) then
                            failed = failed + 1
                        end
                    end
                    vim.schedule(function()
                        local trouble = require("trouble")
                        if trouble.is_open() then
                            trouble.refresh()
                            if failed == 0 then
                                trouble.close()
                            end
                        end
                    end)
                    return {}
                end
            end
        end
    end,
    -- stylua: ignore
    keys = {
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Run File" },
        { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end,                            desc = "Run All Test Files" },
        { "<leader>tt", function() require("neotest").run.run() end,                                        desc = "Run Nearest" },
        { "<leader>tl", function() require("neotest").run.run_last() end,                                   desc = "Run Last" },
        { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "Toggle Summary" },
        { "<leader>tO", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
        { "<leader>to", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle Output Panel" },
        { "<leader>tS", function() require("neotest").run.stop() end,                                       desc = "Stop" },
        { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end,                      desc = "Debug Nearest" },
    },
}
