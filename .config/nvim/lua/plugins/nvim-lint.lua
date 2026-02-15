return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			yaml = { "yamllint" },
			markdown = { "vale" },
			-- python = { "ruff" },
			sql = { "sqlfluff" },
			bash = { "shellcheck" },
			docker = { "hadolint" },
		}
	end,
}
