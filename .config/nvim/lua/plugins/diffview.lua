return {
	"sindrets/diffview.nvim",
	keymap = {
		vim.keymap.set("n", "<leader>dv", ":DiffviewOpen<CR>", { desc = "[D]iff [v]iew open" }),
		vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "[D]iffview [c]lose" }),
	},
}
