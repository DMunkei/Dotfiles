vim.keymap.set("n", "_","zD")
vim.keymap.set("v", "_", "<CMD>:fold<CR>")
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- Remapping escape to something in the homerow
vim.keymap.set("i", "kj", "<esc>")
-- inoremap("<CR>", "<CR><ESC>zzi") Typewriter scrolling

-- vim.keymap.set("n", "<leader>e", ":Ex<CR>")
vim.keymap.set("n", "<leader>e", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>u", ":UndotreeShow<CR>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "zm", ":ZenMode<CR>")
-- Format
vim.keymap.set("n", "<leader>F", ":Neoformat<CR>")

-- Toggle nolist
vim.keymap.set("n", "<F8>", ":set nolist!<CR>")
vim.keymap.set("n", "<F7>", function () require('lsp-inlayhints').toggle() end)
vim.keymap.set("n", "<F10>", "<cmd>IndentBlanklineToggle<CR>")

-- Center page when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "G", "Gzz")

-- walking qflist
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")

-- walking loclist
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

-- Easier split navigation
vim.keymap.set("n", "<M-l>", "<C-w>l")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<leader>x", "<C-w>q")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", "\"_dP")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")

vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

--rename under cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
