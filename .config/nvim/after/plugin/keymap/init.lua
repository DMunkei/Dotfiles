local status_ok, Remap = pcall(require, "dmunkei.keymap")
if not status_ok then
    print("rip")
    return
end
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap



nnoremap("<leader>e", ":Lex<CR>")
nnoremap("<leader>u", ":UndotreeShow<CR>")
-- Center page when scrolling
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")


-- walking qflist
nnoremap("<C-k>", "<cmd>cnext<CR>zz")
nnoremap("<C-j>", "<cmd>cprev<CR>zz")


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



nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
