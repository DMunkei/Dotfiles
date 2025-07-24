return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_enable = false,
			ensure_installed = {
				"jsonls",
				"bashls",
				"emmet_ls",
				"html",
				"cssls",
				-- "tsserver"
				--PYTHON
				"ruff",
				"basedpyright",
				-- "pylsp",
				"ty",
				-- "jedi_language_server",
				"sqlls",
				"dockerls",
				"docker_compose_language_service",
				-- "clangd",
				"marksman",
				"lua_ls",
			},
			automatic_installation = true,
		})
		require("mason-tool-installer").setup({
			ensure_installed = {
				"stylua",
				"codespell",
			},
		})
	end,
}
