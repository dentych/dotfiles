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
		end,
	},
}
