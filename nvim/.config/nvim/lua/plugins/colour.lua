vim.opt.laststatus = 3
vim.opt.fillchars:append({
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┨',
    vertright = '┣',
    verthoriz = '╋',
})
-- Default options:
return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		require'kanagawa'.setup({
		    compile = false,             -- enable compiling the colorscheme
		    undercurl = true,            -- enable undercurls
		    commentStyle = { italic = true },
		    functionStyle = {},
		    keywordStyle = { italic = true},
		    statementStyle = { bold = true },
		    typeStyle = {},
		    transparent = false,         -- do not set background color
		    dimInactive = false,          -- dim inactive window `:h hl-NormalNC`
		    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
		    colors = {                   -- add/modify theme and palette colors
			palette = {},
			theme = {
			    all = {
				ui = { bg_gutter = "none" }
			    },
			},
		    },
		    overrides = function(colors) -- add/modify highlights
			 local theme = colors.theme
			return {
			    TelescopeTitle = { fg = theme.ui.special, bold = true },
			    TelescopePromptNormal = { bg = theme.ui.bg_p1 },
			    TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
			    TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
			    TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
			    TelescopePreviewNormal = { bg = theme.ui.bg_dim },
			    TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },


			    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
			    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
			    PmenuSbar = { bg = theme.ui.bg_m1 },
			    PmenuThumb = { bg = theme.ui.bg_p2 },

			    FloatBorder = { bg = "NONE" },
			    NormalFloat = { bg = "NONE" },
			    LineNr = { fg = "#C0A36E", bg = "NONE"},
			    CursorLineNr = { fg = colors.palette.sakuraPink, bg = "NONE"},
			    -- Visual = { fg = "NONE", bg = colors.palette.lightBlue},
			}
		    end,
		    theme = "wave",              -- Load "wave" theme when 'background' option is not set
		    background = {               -- map the value of 'background' option to a theme
			dark = "wave",           -- try "dragon" !
			light = "lotus"
		    },
		})
		-- setup must be called before loading
		vim.cmd("colorscheme kanagawa")
		-- vim.api.nvim_set_hl(1, "Linenr", {bg = "none", fg = "#C0A36E"})
		vim.cmd [[highlight IndentBlanklineContextStart guisp=#FF0000 gui=underline]]
	end,
}
