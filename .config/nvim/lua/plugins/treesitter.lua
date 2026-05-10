return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "master",
		build = function()
			vim.cmd("TSUpdate")
		end,
		config = function()
			require("nvim-treesitter").install({
				"go",
				"gomod",
				"gosum",
				"gowork",
				"python",
				"javascript",
				"typescript",
				"tsx",
				"dockerfile",
				"gitignore",
				"markdown",
				"html",
				"yaml",
				"json",
				"lua",
				"css",
				"bash",
				"sql",
				"vim",
				"vimdoc",
			})
		end,
	},
}
