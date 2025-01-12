return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"p00f/nvim-ts-rainbow",
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		treesitter.setup({
			modules = {},
			ignore_install = {},
			auto_install = true,
			autotag = {
				enable = true,
			},
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
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
			},
			enabled = false,
			sync_install = false,
			playground = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
