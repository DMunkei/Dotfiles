local ok, blink = pcall(require, "blink.cmp")
if not ok then
	return {}
end
local capabilities = blink.get_lsp_capabilities()
return {
	capabilities = capabilities,
	cmd = { "jedi-language-server" },
	on_init = function(client)
		client.server_capabilities.typeDefinitionProvider = false
		client.server_capabilities.definitionProvider = false
	end,
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
	single_file_support = true,
}
