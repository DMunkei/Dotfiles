return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"ibhagwan/fzf-lua", -- optional
	},
	branch = "master",
	config = function()
		neogit = require("neogit")
		neogit.setup({
			graph_style = "unicode",
			-- kind="split",
			signs = {
				hunk = { "", "" },
				item = { "➡", "⬇" },
				section = { "➡", "⬇" },
			},
		})
	end,
	vim.keymap.set("n", ",g", ":Neogit<cr>"),
}
