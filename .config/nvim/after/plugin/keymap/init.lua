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

-- Netrw
nnoremap("<leader>e", ":Lex<CR>")

-- Center page when scrolling
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")



nnoremap("<C-k>", "<cmd>cnext<CR>zz")
nnoremap("<C-j>", "<cmd>cprev<CR>zz")


