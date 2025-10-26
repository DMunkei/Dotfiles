return {
	"mbbill/undotree",
	lazy = true,
	cmd = "UndotreeToggle",
	keys = {
		{
			"<leader>u",
			"<cmd>UndotreeToggle<CR>",
			desc = "[Undotree] Toggle",
		},
		{ "J <cmd>UndotreeNextState<CR> " },
		{ "K <cmd>UndotreePreviousState<CR> " },
	},
}
