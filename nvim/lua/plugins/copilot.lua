return {
    "github/copilot.vim",
    event = "BufEnter",
    keys = {
        { "<C-z>", "<Plug>(copilot-dismiss)", mode = "i"},
        { "<C-S-e>", "<Plug>(copilot-accept-word)", mode = "i"},
        { "<C-l>", "<Plug>(copilot-accept-line)", mode = "i"},
        { "<C-]>", "<Plug>(copilot-next)", mode = "i"},
        { "<C-[>", "<Plug>(copilot-previous)", mode = "i"},
        { "<C-e>", 'copilot#Accept("\\<CR>")', mode = 'i', expr = true, replace_keycodes = false },
    },
    config = function()
        vim.g.copilot_no_tab_map = true
    end,
}
