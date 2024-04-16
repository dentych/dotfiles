-- navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = "Go to left window", remap = true})
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = "Go to below window", remap = true})
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = "Go to above window", remap = true})
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "Go to right window", remap = true})

-- lazy.nvim
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", {desc = "Open Lazy"})

-- quickfix
vim.keymap.set("n", "<C-w>c", "<cmd>ccl<cr>", { desc = "Close quickfix window" })

-- git
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" } )

vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer" })

vim.keymap.set("n", "<esc>", "<cmd>noh<cr>", { desc = "Remove highlighting" })

