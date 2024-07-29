return {
	"folke/trouble.nvim",
	cmd = { "TroubleToggle", "Trouble" },
	keys = {
		{ "<leader>xx", "<cmd>Trouble document_diagnostics<cr>", desc = "Diagnostics (Trouble)" },
		{ "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>xl", "<cmd>Trouble loclist<cr>", desc = "Location List (Trouble)" },
		{ "<leader>xq", "<cmd>Trouble qflist<cr>", desc = "Quickfix List (Trouble)" },
		{
			"[q",
			function()
				if require("trouble").is_open() then
					require("trouble").prev({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cprev)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Previous Trouble/Quickfix Item",
		},
		{
			"]q",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cnext)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Next Trouble/Quickfix Item",
		},
	},
}
