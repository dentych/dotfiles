local function git_or_find_files()
    local path = vim.loop.cwd() .. "/.git"
    local ok, err = vim.loop.fs_stat(path)
    if ok then
        require("telescope.builtin").git_files()
    else
        require("telescope.builtin").find_files()
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
    'nvim-telescope/telescope.nvim',
    branch = "master",
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        pickers = {
            git_files = {
                show_untracked = true,
            },

            lsp_document_symbols = {
                symbol_width = 50,
            }
        },
        defaults = {
            path_display = { "filename_first" },
        },
    },
    keys = {
        -- find
        { "<leader><space>", git_or_find_files,                                                            desc = "Find files" },
        { "<leader>ff",      git_or_find_files,                                                            desc = "Find files" },
        { "<leader>fa",      function() require("telescope.builtin").find_files({ no_ignore = true }) end, desc = "Find files (do not respect .gitignore)" },
        { "<leader>fb",      "<cmd>Telescope buffers<cr>",                                                 desc = "Find buffers" },
        -- search
        { "<leader>sg",      "<cmd>Telescope live_grep<cr>",                                               desc = "Live grep" },
        { "<leader>ss",      "<cmd>Telescope lsp_document_symbols<cr>",                                    desc = "Search for symbols (Document)" },
        { "<leader>sS",      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",                           desc = "Search for symbols (Workspace)" },
        { "<leader>sG",      liveGrepCurrentFileDir,                                                       desc = "Live grep search in file's current directory" },
        { "<leader>sa",      liveGrepIgnoreHidden,                                                         desc = "Live grep include hidden" },
    },
}
