local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   visual_mode = "v",
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>v", ":vsplit<CR>", opts)


-- NetRW
keymap("n", "<leader>e", "<cmd>Lexplore<CR>", opts)


-- Telescope
keymap("n","<leader>s", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n","<leader>S", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n","<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n","<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
