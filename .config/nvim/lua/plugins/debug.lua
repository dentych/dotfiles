return {
	{
		"mfussenegger/nvim-dap",
		recommended = true,
		desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

		dependencies = {},
	         -- stylua: ignore
	       keys = {
	           { "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
	           { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
	           { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
	           { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
	           { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
	           { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
	           { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
	           { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
	           { "<leader>dj", function() require("dap").down() end, desc = "Down" },
	           { "<leader>dk", function() require("dap").up() end, desc = "Up" },
	           { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
	           { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
	           { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
	           { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
	           { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
	           { "<leader>ds", function() require("dap").session() end, desc = "Session" },
	           { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
	           { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
	       },
		config = function()
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

			-- for name, sign in pairs(LazyVim.config.icons.dap) do
			-- 	sign = type(sign) == "table" and sign or { sign }
			-- 	vim.fn.sign_define(
			-- 		"Dap" .. name,
			-- 		{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
			-- 	)
			-- end

			-- setup dap config by VsCode launch.json file
			local vscode = require("dap.ext.vscode")
			local json = require("plenary.json")
			vscode.json_decode = function(str)
				return vim.json.decode(json.json_strip_comments(str))
			end

			-- Extends dap.configurations with entries read from .vscode/launch.json
			if vim.fn.filereadable(".vscode/launch.json") then
				vscode.load_launchjs()
			end
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			ensure_installed = { "delve" },
		},
	},
	{ "leoluz/nvim-dap-go" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
	       -- stylua: ignore
		keys = {
			{ "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
			{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
		},
		opts = {},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end
		end,
	},
}
