return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = { "InsertEnter", "LspAttach" },
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},
}
