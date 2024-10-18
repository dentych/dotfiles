-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}

local project_files = function()
	local opts = {} -- define here if you want to define something

	local cwd = vim.fn.getcwd()
	if is_inside_work_tree[cwd] == nil then
		vim.fn.system("git rev-parse --is-inside-work-tree")
		is_inside_work_tree[cwd] = vim.v.shell_error == 0
	end

	if is_inside_work_tree[cwd] then
		require("telescope.builtin").git_files(opts)
	else
		require("telescope.builtin").find_files(opts)
	end
end

-- Live grep search in file's current directory
-- Todo: Make it possible to hover over a directory in neo-tree and live grep in that directory
local function liveGrepCurrentFileDir()
	require("telescope.builtin").live_grep({ search_dirs = { vim.api.nvim_buf_get_name(0):match("(.*/)") } })
end

local function liveGrepIgnoreHidden()
	require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
end

return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			path_display = { "filename_first" },
			layout_config = {
				width = 0.95,
				height = 0.95,
				preview_cutoff = 250,
			},
		},
		pickers = {
			git_files = {
				show_untracked = true,
			},

			lsp_document_symbols = {
				symbol_width = 0.75,
			},

			lsp_dynamic_workspace_symbols = {
				fname_width = 0.15,
				symbol_width = 0.75,
				layout_config = {
					preview_width = 120,
				},
			},

			buffers = {
				mappings = {
					n = {
						["d"] = require("telescope.actions").delete_buffer,
					},
				},
			},
		},
	},
	keys = {
		-- find
		{
			"<leader><space>",
			project_files,
			desc = "Find files",
		},
		{
			"<leader>ff",
			project_files,
			desc = "Find files",
		},
		{
			"<leader>fa",
			function()
				require("telescope.builtin").find_files({ no_ignore = true })
			end,
			desc = "Find files (do not respect .gitignore)",
		},
		{
			"<leader>fb",
			"<cmd>Telescope buffers<cr>",
			desc = "Find buffers",
		},
		-- search
		{
			"<leader>sg",
			"<cmd>Telescope live_grep<cr>",
			desc = "Live grep",
		},
		{
			"<leader>ss",
			"<cmd>Telescope lsp_document_symbols<cr>",
			desc = "Search for symbols (Document)",
		},
		{
			"<leader>sS",
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			desc = "Search for symbols (Workspace)",
		},
		{
			"<leader>sG",
			liveGrepCurrentFileDir,
			desc = "Live grep search in file's current directory",
		},
		{
			"<leader>sa",
			liveGrepIgnoreHidden,
			desc = "Live grep include hidden",
		},
	},
}
