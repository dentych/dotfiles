local open_mini = function()
	local mf = require("mini.files")
	local _ = mf.close() or mf.open(vim.api.nvim_buf_get_name(0), false)
	vim.defer_fn(function()
		mf.reveal_cwd()
	end, 30)
end

return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function(_, config)
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.comment").setup()
			require("mini.bufremove").setup()
			require("mini.ai").setup()
			require("mini.indentscope").setup()
			require("mini.starter").setup()

			require("mini.files").setup()
		end,
		keys = {
			{ "<leader>e", open_mini },
		},
	},
}
