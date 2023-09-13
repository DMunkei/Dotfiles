return {
	"lukas-reineke/indent-blankline.nvim",

	config = function()
		require("indent_blankline").setup({
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = true,
			disable_with_nolist = true,
		})
		vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
		vim.cmd([[highlight IndentBlanklineContextStart guisp=#FF0000 gui=underline]])
	end,
}
