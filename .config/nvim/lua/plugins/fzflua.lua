return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		-- # wot
		fzf.setup({
			grep = {
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --pcre2",
			},
			actions = {
				-- Below are the default actions, setting any value in these tables will override
				-- the defaults, to inherit from the defaults change [1] from `false` to `true`
				files = {
					-- true,        -- uncomment to inherit all the below in your custom config
					-- Pickers inheriting these actions:
					--   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
					--   tags, btags, args, buffers, tabs, lines, blines
					-- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
					-- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
					-- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
					["enter"] = fzf.actions.file_edit_or_qf,
					["ctrl-s"] = fzf.actions.file_split,
					["ctrl-v"] = fzf.actions.file_vsplit,
					["ctrl-t"] = fzf.actions.file_tabedit,
					["alt-q"] = fzf.actions.file_sel_to_qf,
				},
			},
			winopts = {
				-- split = "belowright new",-- open in a split instead?
				-- "belowright new"  : split below
				-- "aboveleft new"   : split above
				-- "belowright vnew" : split right
				-- "aboveleft vnew   : split left
				-- Only valid when using a float window
				-- (i.e. when 'split' is not defined, default)
				height = 0.85, -- window height
				width = 0.80, -- window width
				row = 0.35, -- window row position (0=top, 1=bottom)
				col = 0.50, -- window col position (0=left, 1=right)
				-- border argument passthrough to nvim_open_win()
				border = "rounded",
				-- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
				backdrop = 60,
				-- title         = "Title",
				-- title_pos     = "center",        -- 'left', 'center' or 'right'
				-- title_flags   = false,           -- uncomment to disable title flags
				fullscreen = true, -- start fullscreen?
				-- enable treesitter highlighting for the main fzf window will only have
				-- effect where grep like results are present, i.e. "file:line:col:text"
				-- due to highlight color collisions will also override `fzf_colors`
				-- set `fzf_colors=false` or `fzf_colors.hl=...` to override
				treesitter = {
					enabled = true,
					fzf_colors = { ["hl"] = "-1:reverse", ["hl+"] = "-1:reverse" },
				},
				preview = {
					-- default     = 'bat',           -- override the default previewer?
					-- default uses the 'builtin' previewer
					border = "rounded", -- preview border: accepts both `nvim_open_win`
					-- and fzf values (e.g. "border-top", "none")
					-- native fzf previewers (bat/cat/git/etc)
					-- can also be set to `fun(winopts, metadata)`
					wrap = false, -- preview line wrap (fzf's 'wrap|nowrap')
					hidden = false, -- start preview hidden
					vertical = "down:45%", -- up|down:size
					horizontal = "right:55%", -- right|left:size
					layout = "flex", -- horizontal|vertical|flex
					flip_columns = 100, -- #cols to switch to horizontal on flex
					-- Only used with the builtin previewer:
					title = true, -- preview border title (file/buf)?
					title_pos = "center", -- left|center|right, title alignment
					scrollbar = "float", -- `false` or string:'float|border'
					-- float:  in-window floating border
					-- border: in-border "block" marker
					scrolloff = -1, -- float scrollbar offset from right
					-- applies only when scrollbar = 'float'
					delay = 20, -- delay(ms) displaying the preview
					-- prevents lag on fast scrolling
					winopts = { -- builtin previewer window options
						number = true,
						relativenumber = false,
						cursorline = true,
						cursorlineopt = "both",
						cursorcolumn = false,
						signcolumn = "no",
						list = false,
						foldenable = false,
						foldmethod = "manual",
					},
				},
				on_create = function()
					-- called once upon creation of the fzf main window
					-- can be used to add custom fzf-lua mappings, e.g:
					--   vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
				end,
				-- called once _after_ the fzf interface is closed
				-- on_close = function() ... end
			},
			keymap = { fzf = { true, ["ctrl-q"] = "select-all+accept", ["ctrl-a"] = "accept" } },
		})
	end,
	keys = {
		{
			"<C-f>",
			"<cmd>FzfLua files<cr>",
			"Fzf Find Files",
		},
		{
			"<C-h>",
			"<cmd>FzfLua helptags<cr>",
			"[F]zf [H]elptags",
		},
		{
			"<C-g>",
			"<cmd>FzfLua live_grep<cr>",
			"Fzf Live Grep",
		},
		{
			"<leader>l",
			"<cmd>FzfLua grep_cword<cr>",
			"Fzf current Word grep",
		},
		{
			"<leader>f",
			"<cmd>FzfLua blines<cr>",
			"Fzf [F]ind in open buffer",
		},
		{
			"<leader><leader>",
			"<cmd>FzfLua buffers<cr>",
			"FZF show current buffers",
		},
		{
			",s",
			"<cmd>FzfLua git_status<cr>",
			"Fzf Show Git Status",
		},
		{
			",b",
			"<cmd>FzfLua git_branches<cr>",
			"Fzf Show Git Branches",
		},
		{
			"<leader>?",
			"<cmd>FzfLua builtin<cr>",
			"FZF show builtin",
		},
	},
}
