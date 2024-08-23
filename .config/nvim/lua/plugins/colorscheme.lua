return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {
			contrast = "hard",
		},
		config = function()
			require("gruvbox").setup(opts)
			vim.cmd.colorscheme("gruvbox")
			vim.api.nvim_set_hl(0, "LineNr", { fg = "lightgray" })
		end,
	},
	{
		"catppuccin/nvim",
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
