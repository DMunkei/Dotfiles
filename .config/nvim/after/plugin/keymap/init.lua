local status_ok, Remap = pcall(require, "dmunkei.keymap")
if not status_ok then
    print("rip")
    return
end

local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

nnoremap("<leader>e", ":Lex<CR>")
nnoremap("<leader>u", ":UndotreeShow<CR>")

-- Format
nnoremap("<leader>F", ":Neoformat<CR>")

-- Toggle nolist
nnoremap("<F8>", ":set nolist!<CR>")

-- Center page when scrolling
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- walking qflist
nnoremap("<C-j>", "<cmd>cnext<CR>zz")
nnoremap("<C-k>", "<cmd>cprev<CR>zz")


-- Easier split navigation
nnoremap("<M-l>", "<C-w>l")
nnoremap("<M-k>", "<C-w>k")
nnoremap("<M-j>", "<C-w>j")
nnoremap("<M-h>", "<C-w>h")

-- greatest remap ever
xnoremap("<leader>p", "\"_dP")

-- next greatest remap ever : asbjornHaland
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

--rename under cursor
nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
