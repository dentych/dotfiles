return {
	{
		"morhetz/gruvbox",
		priority = 1000,
		config = function()
			--vim.cmd.colorscheme("gruvbox")

			vim.api.nvim_set_hl(0, "Comment", { link = "GruvboxFg0" })
			-- Write same highlight methods as the three above, but without the hl- prefix
			vim.api.nvim_set_hl(0, "LspReferenceText", { link = "GruvboxFg0" })
			vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReferenceText" })
			vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReferenceText" })
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
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
