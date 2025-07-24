return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		conform.setup({

			formatters_by_ft = {
				lua = { "stylua" },
				-- python = { "black", "ruff_organize_imports" },
				python = {
					-- To fix auto-fixable lint errors.
					"ruff_fix",
					-- To run the Ruff formatter.
					"ruff_format",
					-- To organize the imports.
					"ruff_organize_imports",
				},
				bash = { "shfmt" },
				json = { "jq" },
				yaml = { "yamlfix", "yamlfmt" },
				sql = { "sqlfluff" },
			},
			format_on_save = { lsp_fallback = true, timeout_ms = 2000 },
			formatters = {
				sqlfluff = {
					prepend_args = { "--dialect=mysql" },
				},
			},
			vim.keymap.set({ "v", "n" }, "<leader>L", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 400,
				})
			end),
		})
	end,
}
