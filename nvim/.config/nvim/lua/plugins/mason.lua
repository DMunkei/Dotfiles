return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		mason.setup({})
		mason_lspconfig.setup({
			ensure_installed = {
				"tsserver",
				"html",
				"cssls",
				"pyright",
				"ruff_lsp",
				"lua_ls",
				"sqlls",
				"bashls",
				"volar",
				"dockerls",
				"clangd",
				"docker_compose_language_service",
				"marksman",
				"gopls",
				"emmet_ls",
				"jedi_language_server",
			}
		})
	end,
}
