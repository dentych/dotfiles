vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

		for _, client in ipairs(clients) do
			if client.server_capabilities.documentHighlightProvider then
				vim.lsp.buf.document_highlight()
				return
			end
		end
	end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})
