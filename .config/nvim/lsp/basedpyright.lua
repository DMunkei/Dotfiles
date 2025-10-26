local ok, blink = pcall(require, "blink.cmp")
if not ok then
	return {}
end
local capabilities = blink.get_lsp_capabilities()
return {
	capabilities = { capabilities, didChangeWatchedFiles = { dynamicRegistration = true } },
	cmd = { "basedpyright-langserver", "--stdio" },
	on_init = function(client)
		client.server_capabilities.documentSymbolsProvider = false
		client.server_capabilities.documentSymbolProvider = false
		-- client.server_capabilities.definitionProvider = false
		-- client.server_capabilities.typeDefinitionProvider = false
	end,
	root_markers = { ".git", "pyproject.toml" },
	filetypes = { "python" },
	settings = {
		pythonVersion = "3.12",
		disableOrganizeImports = true,
		basedpyright = {
			analysis = {
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
				inlayHints = {
					callArgumentNames = true,
					functionReturnTypes = true,
				},
				typeCheckingMode = "standard",
				diagnosticSeverityOverrides = {
					reportUnannotatedClassAttribute = "none",
					reportAttributeAccessIssue = "none",
					reportIncompatibleVariableOverride = "none",
					reportIncompatibleMethodOverride = "none",
					reportAssignmentType = "none",
					reportUnreachable = false,
				},
			},
		},
	},
}
