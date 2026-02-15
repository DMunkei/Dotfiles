local ok, blink = pcall(require, "blink.cmp")
if not ok then
	return {}
end
local capabilities = blink.get_lsp_capabilities()
return {
	capabilities = capabilities,
	on_init = function(client)
		client.server_capabilities.typeDefinitionProvider = true
		client.server_capabilities.definitionProvider = true
		client.server_capabilities.referencesProvider = true
		client.server_capabilities.hoverProvider = true
		client.server_capabilities.documentSymbolProvider = true
	end,
	cmd = { "ty", "server" },
	filetypes = { "python" },
	single_file_support = true,
	root_markers = {
		"pyproject.toml",
		"ty.toml",
		".git",
	},
	settings = {
		logLevel = "error",
		pythonVersion = "3.12",
		pythonPlatform = "darwin",
	},
}
