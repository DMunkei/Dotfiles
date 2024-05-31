return {
	"mbbill/undotree",
	lazy = true,
	cmd = "UndotreeToggle",
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "[Undotree] Toggle" },
	},
	config = function()
		vim.g.undotree_WindowLayout = 2
	end,
}
