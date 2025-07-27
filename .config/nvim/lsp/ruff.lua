local ok, blink = pcall(require, "blink.cmp")
if not ok then
	return {}
end
local capabilities = blink.get_lsp_capabilities()
return {
	capabilities = capabilities,
	cmd = { "ruff", "server" },
	on_init = function(client)
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.typeDefinitionProvider = false
	end,
	filetypes = { "python" },
	single_file_support = true,
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
	settings = {
		logLevel = "error",
		lineLength = 120,
		targetVersion = "py312",
		format = {
			quoteStyle = "double",
			skipMagicTrailingComma = true,
			lineEnding = "lf",
			preview = false,
		},
		lint = {
			enabled = true,
			preview = true,
		},
	},
}
