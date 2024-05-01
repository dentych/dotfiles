return {
	{
		"morhetz/gruvbox",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("gruvbox")

			vim.api.nvim_set_hl(0, "Comment", { fg = "lightgray" })
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
