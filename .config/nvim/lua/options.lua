-- global stuff
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable weird <C-c>o shortcuts for sql files, that are apparently built into neovim :exploding_brain:
vim.g.omni_sql_no_default_maps = 1

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.confirm = true -- confirm to save if exiting modified buffer
opt.expandtab = true
opt.foldlevelstart = 99
opt.foldmethod = "indent"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.undofile = true
opt.undolevels = 10000
opt.termguicolors = true
opt.updatetime = 1000
opt.splitright = true
