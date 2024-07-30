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
		require("neotest").setup(opts)
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
