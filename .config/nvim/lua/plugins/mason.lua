return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	init = function(_)
		local pylsp = require("mason-registry").get_package("python-lsp-server")
		pylsp:on("install:success", function()
			local function mason_package_path(package)
				local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
				return path
			end

			local path = mason_package_path("python-lsp-server")
			local command = path .. "/venv/bin/pip"
			local args = {
				"install",
				"-U",
				"pylsp-rope",
			}

			require("plenary.job")
				:new({
					command = command,
					args = args,
					cwd = path,
				})
				:start()
		end)
	end,
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"jsonls",
				"bashls",
				"emmet_ls",
				"html",
				"cssls",
				-- "tsserver"
				--PYTHON
				"basedpyright",
				"pylsp",
				-- "pyright",
				-- "jedi_language_server",
				-- "ruff_lsp",
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
				"black",
				"isort",
				-- "ruff",
				-- "pylint",
				"codespell",
			},
		})
	end,
}
