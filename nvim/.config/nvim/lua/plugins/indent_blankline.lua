return {
	"lukas-reineke/indent-blankline.nvim",
    main = "ibl",
	config = function()
        require("ibl").setup({
            enabled = false,
            debounce = 100,
            -- indent = { char = "|" },
            whitespace = { highlight = { "Whitespace", "NonText" } },
            scope = { exclude = { language = { "lua" } } },
        })
		-- vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
		-- vim.cmd([[highlight IndentBlanklineContextStart guisp=#FF0000 gui=underline]])
	end,
}
