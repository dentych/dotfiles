return {
	-- "rmagatti/auto-session",
	-- config = function()
	-- 	require("auto-session").setup({
	-- 		log_level = "error",
	-- 		auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
	-- 		pre_save_cmds = { "Neotree close" },
	-- 		--post_restore_cmds = { "Neotree" },
	-- 	})
	-- Lua
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Load session for current directory",
			},
			{
				"<leader>qS",
				function()
					require("persistence").select()
				end,
				desc = "Select a session to load",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Load last session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Stop Persistence (session won't be saved on exit)",
			},
		},
	}, -- end,
}
