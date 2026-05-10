return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	opts = {},
	init = function()
		local ensureInstalled = {
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
		}
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				-- Enable treesitter highlighting and disable regex syntax
				pcall(vim.treesitter.start)
				-- Enable treesitter-based indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
		local alreadyInstalled = require("nvim-treesitter.config").get_installed()
		local parsersToInstall = vim.iter(ensureInstalled)
			:filter(function(parser)
				return not vim.tbl_contains(alreadyInstalled, parser)
			end)
			:totable()
		require("nvim-treesitter").install(parsersToInstall)
	end,
}
