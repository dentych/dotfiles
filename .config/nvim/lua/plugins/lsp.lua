return {
	{
		"williamboman/mason.nvim",
		keys = {
			{ "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		event = "VimEnter",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function(_, opts)
			require("mason").setup()
			require("mason-lspconfig").setup()

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["gopls"] = function()
					require("lspconfig").gopls.setup({
						capabilities = capabilities,
						settings = {
							gopls = {
								buildFlags = { "-tags=integration" },
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
							},
						},
					})
				end,
			})

			-- setup keys
			local builtin = require("telescope.builtin")
			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<space>xf", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
			vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
			vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			vim.keymap.set("n", "<space>xl", vim.diagnostic.setloclist, { desc = "Set loclist" })

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					if client.supports_method("textDocument/definition") then
						vim.keymap.set("n", "gd", function()
							builtin.lsp_definitions()
						end, { desc = "Go to definition" })
					end
					if client.supports_method("textDocument/typeDefinition") then
						vim.keymap.set("n", "gt", function()
							builtin.lsp_type_definitions()
						end, { desc = "Go to type definition" })
					end
					-- textDocument/implementation
					if client.supports_method("textDocument/implementation") then
						vim.keymap.set("n", "gi", function()
							builtin.lsp_implementations()
						end, { desc = "Go to implementation" })
					end
					-- textDocument/references
					if client.supports_method("textDocument/references") then
						vim.keymap.set("n", "gr", function()
							builtin.lsp_references()
						end, { desc = "Go to references" })
					end
					-- textDocument/hover
					if client.supports_method("textDocument/hover") then
						vim.keymap.set("n", "gh", function()
							vim.lsp.hover()
						end, { desc = "Show hover" })
					end
					-- textDocument/codeAction
					if client.supports_method("textDocument/codeAction") then
						vim.keymap.set("n", "<leader>ca", function()
							vim.lsp.buf.code_action()
						end, { desc = "Code action" })
					end
					-- textDocument/signatureHelp
					if client.supports_method("textDocument/signatureHelp") then
						vim.keymap.set("n", "gs", function()
							vim.lsp.signature_help()
						end, { desc = "Show signature help" })
						vim.keymap.set("i", "<C-k>", function()
							vim.lsp.signature_help()
						end, { desc = "Show signature help" })
					end
					-- textDocument/rename
					if client.supports_method("textDocument/rename") then
						vim.keymap.set("n", "<leader>cr", function()
							vim.lsp.buf.rename()
						end, { desc = "Rename" })
					end
				end,
			})
		end,
	},
}
