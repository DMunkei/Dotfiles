return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
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
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost" },
		-- cmd = "TSContext Toggle",
		keys = {
			{ "<leader>tct", "<cmd>TSContext toggle<CR>", desc = "TS Context Toggle" },
		},
		opts = { mode = "cursor" },
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},
		},
	},
}
-- 			playground = { enable = true },
-- 			-- textobjects = {
-- 			-- 	select = {
-- 			-- 		enable = true,
-- 			-- 		lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
-- 			-- 		keymaps = {
-- 			-- 			-- You can use the capture groups defined in textobjects.scm
-- 			-- 			["aa"] = "@parameter.outer",
-- 			-- 			["ia"] = "@parameter.inner",
-- 			-- 			["af"] = "@function.outer",
-- 			-- 			["if"] = "@function.inner",
-- 			-- 			["ac"] = "@class.outer",
-- 			-- 			["ic"] = "@class.inner",
-- 			-- 		},
-- 			-- 	},
-- 			-- },
--
-- 			-- incremental_selection = {
-- 			-- 	enable = true,
-- 			-- 	keymaps = {
-- 			-- 		init_selection = "<c-space>",
-- 			-- 		node_incremental = "<c-space>",
-- 			-- 		scope_incremental = "<c-s>",
-- 			-- 		node_decremental = "<bs>",
-- 			-- 	},
-- 			-- },
