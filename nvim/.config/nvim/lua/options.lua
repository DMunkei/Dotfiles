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
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.scrolloff = 8
vim.o.winbar = "%f"

vim.o.completeopt = 'menuone,noselect'

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true


-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Make the current cursorline have a different colour and don't highlight the entire line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number,line"

vim.opt.colorcolumn = "120"
vim.opt.signcolumn = "yes"

vim.opt.guicursor:append({"i:block","i:blinkon5"})

vim.opt.list = false
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.opt.termguicolors = true

vim.opt.fillchars:append "diff:/"

vim.diagnostic.config({
    virtual_text = true,
    float = {
        focusable = true,
        source = "always",
    },
})


local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

vim.cmd [[sign define DiagnosticSignError text=󰅙 texthl=DiagnosticSignError linehl= numhl=]]
vim.cmd [[sign define DiagnosticSignWarn text=󰋼  texthl=DiagnosticSignWarn linehl= numhl=]]
vim.cmd [[sign define DiagnosticSignInfo text=󰌵 texthl=DiagnosticSignInfo linehl= numhl=]]
vim.cmd [[sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=]]
