-- local ok, blink = pcall(require, "blink.cmp")
-- if not ok then
-- 	return {}
-- end
-- local capabilities = blink.get_lsp_capabilities()
-- return {
-- 	capabilities = capabilities,
-- 	cmd = { "yaml-language-server", "--stdio" },
-- 	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
-- 	root_markers = function(fname)
-- 		return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
-- 	end,
-- 	settings = {
-- 		yaml = {
-- 			schemaStore = {
-- 				enable = false,
-- 				url = "",
-- 			},
--
-- 			schemas = require("schemastore").yaml.schemas(),
-- 		},
-- 		redhat = {
-- 			telemetry = {
-- 				enabled = false,
-- 			},
-- 		},
-- 	},
-- }
local ok, blink = pcall(require, "blink.cmp")
if not ok then
	return {}
end

local capabilities = blink.get_lsp_capabilities()

return {
	name = "yamlls",
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	capabilities = capabilities,
	root_dir = function(fname)
		return vim.fs.dirname(vim.fs.find({
			".git",
			"azure-pipelines.yml",
			"docker-compose.yml",
			".yamllint",
		}, { upward = true, path = fname })[1])
	end,
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = {
				{
					name = "Azure Pipelines",
					uri = "https://json.schemastore.org/azure-pipelines.json",
					fileMatch = { "azure-pipelines.yml", "azure-pipelines.yaml" },
				},
			},
		},
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
	},
}
