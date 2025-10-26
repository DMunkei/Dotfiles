vim.o.winwidth = 100
vim.o.winminwidth = 20
vim.o.winheight = 10
vim.o.winminheight = 5

vim.opt.previewheight = 50
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.showmode = false
vim.opt.mouse = "a"
vim.opt.breakindent = true
vim.opt.inccommand = "split"

vim.opt.clipboard = "unnamedplus"
-- Give more space for displaying messages.
vim.opt.cmdheight = 1

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.autoread = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.scrolloff = 10
vim.o.winbar = "%f"
vim.o.winborder = "rounded"

vim.o.completeopt = "menuone,noselect"

vim.o.foldcolumn = "1" -- '0' is not bad
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
vim.opt.signcolumn = "auto:1-4"

vim.opt.guicursor:append({ "i:block", "i:blinkon5" })

vim.opt.list = false
vim.opt.listchars = { eol = "↴", space = "⋅", tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.termguicolors = true

vim.opt.fillchars:append("diff:/")

vim.hl.priorities.semantic_tokens = 95

vim.diagnostic.config({
	update_in_insert = true,
	virtual_text = {
		prefix = "⊛",
		format = function(diagnostic)
			local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
			return string.format("%s %s", code, diagnostic.message)
		end,
	},
	current_line = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "E",
			[vim.diagnostic.severity.WARN] = "W",
			[vim.diagnostic.severity.INFO] = "I",
			[vim.diagnostic.severity.HINT] = "H",
		},
	},
	under_curl = false,
	float = {
		border = "rounded",
		style = "minimal",
		focusable = true,
		source = true,
	},
})

local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.jump
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ count = next, severity = severity })
	end
end

-- vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
-- vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(1, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(-1, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(1, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(-1, "WARN"), { desc = "Prev Warning" })
