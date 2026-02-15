-- Clear highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- remap save
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")

-- Remapping escape to something in the homerow
vim.keymap.set("i", "kj", "<esc>")
-- inoremap("<CR>", "<CR><ESC>zzi") Typewriter scrolling

-- vim.keymap.set("n", "<leaer>e", ":Ex<CR>")
-- vim.keymap.set("n", "<leader>e", require("oil").open, { desc = "Open parent directory" })

vim.keymap.set("n", "'", "<Cmd>norm gcc<CR>")
vim.keymap.set("v", "'", "gc", { remap = true })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Toggle nolist
vim.keymap.set("n", "<F8>", ":set nolist!<CR>")

-- Center page when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "]]", "]]zz")
vim.keymap.set("n", "[[", "[[zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

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

-- greatest remap ever
vim.keymap.set("x", "<leader>p", '"_dP')
-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

--rename under cursor
vim.keymap.set("n", "<leader>/", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- vim.keymap.set("n", "<leader>/", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left><C-f>")

vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>q", "<c-w>q")
