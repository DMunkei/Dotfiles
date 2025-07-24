return {
	"sindrets/diffview.nvim",
	opts = {
		enhanced_diff_hl = true,
		view = {
			merge_tool = {
				layout = "diff3_mixed",
				disable_diagnostics = true,
				winbar_info = true,
			},
		},
	},
	keymap = {
		vim.keymap.set("n", ",f", ":DiffviewFileHistory", { desc = "[D]iffview [F]il history" }),
		vim.keymap.set("n", ",v", ":DiffviewOpen", { desc = "[D]iff [v]iew open" }),
		vim.keymap.set("n", ",c", ":DiffviewClose<CR>", { desc = "[D]iffview [c]lose" }),
	},
}
