vim.opt.laststatus = 3
vim.opt.fillchars:append({
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┨",
	vertright = "┣",
	verthoriz = "╋",
})
--
-- Default options:
return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors
				palette = {},
				theme = {
					all = {
						ui = { bg_gutter = "none" },
					},
				},
			},
			overrides = function(colors) -- add/modify highlights
				local theme = colors.theme
				return {

					NeogitHunkHeaderHighlight = { fg = "#C0A36E", bold = true },
					NeogitDiffContextHighlight = {},

					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },

					BlinkCmpMenuBorder = { fg = "", bg = "" },

					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					-- LineNr = { fg = "#C0A36E", bg = "NONE" },
					CursorLineNr = { fg = colors.palette.sakuraPink, bg = "NONE" },
					-- ColorColumn = { fg = colors.palette.sakuraPink, bg = "NONE" },
					-- Visual = { fg = "NONE", bg = colors.palette.lightBlue},
				}
			end,
			theme = "wave", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		})
		-- setup must be called before loading
		vim.cmd("colorscheme kanagawa")
		-- vim.api.nvim_set_hl(1, "Linenr", {bg = "none", fg = "#C0A36E"})
		-- vim.cmd([[highlight ColorColumn guibg=#C0A36E]])
		-- vim.cmd([[highlight BlinkCmpMenuBorder guibg=]])
	end,
}
