vim.g.mapleader = " "

vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
 --
-- Give more space for displaying messages.
vim.opt.cmdheight = 1

vim.opt.relativenumber = true
vim.opt.number = true


vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.splitright = true

vim.opt.expandtab = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth =4

vim.opt.wrap = false

vim.opt.scrolloff = 8

vim.o.winbar = "%f"
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
