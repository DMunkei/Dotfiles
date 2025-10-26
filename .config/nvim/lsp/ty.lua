return {
	on_init = function(client)
		client.server_capabilities.typeDefinitionProvider = false
		client.server_capabilities.definitionProvider = false
		client.server_capabilities.completionProvider = false
		client.server_capabilities.referencesProvider = false
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.documentSymbolProvider = false
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
