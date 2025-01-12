return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			python = { "flake8" },
		}
		vim.keymap.set("n", "<leader>o", function()
			lint.try_lint()
		end, { desc = "Lint file" })
	end,
}
