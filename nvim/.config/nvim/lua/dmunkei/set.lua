vim.g.mapleader = " "

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.clipboard = "unnamedplus"
-- Give more space for displaying messages.
vim.opt.cmdheight = 1

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.autoread = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.splitright = true
vim.opt.splitbelow = true


vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.scrolloff = 8
vim.o.winbar = "%f"

vim.o.completeopt = 'menuone,noselect'

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Make the current cursorline have a different colour and don't highlight the entire line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.colorcolumn = "120"
vim.opt.signcolumn = "yes"

vim.opt.guicursor:append({"i:block","i:blinkon5"})

vim.opt.list = false
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.opt.termguicolors = true

vim.opt.fillchars:append "diff:/"

vim.diagnostic.config({
    virtual_text = false,
    float = {
        focusable = true,
        source = "always",
    },
})
vim.cmd [[sign define DiagnosticSignError text=󰅙 texthl=DiagnosticSignError linehl= numhl=]]
vim.cmd [[sign define DiagnosticSignWarn text=󰋼 texthl=DiagnosticSignWarn linehl= numhl=]]
vim.cmd [[sign define DiagnosticSignInfo text=󰌵 texthl=DiagnosticSignInfo linehl= numhl=]]
vim.cmd [[sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=]]
