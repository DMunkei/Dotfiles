return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				go = { "goimports", "gofmt" },
				-- Use a sub-list to run only the first available formatter
				javascript = { { "prettierd", "prettier" } },
			},
		})
	end,
}
