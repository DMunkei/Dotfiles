local ok, blink = pcall(require, "blink.cmp")
if not ok then
	return {}
end
local capabilities = blink.get_lsp_capabilities()
return {
	capabilities = capabilities,
	default_config = {
		cmd = { "azure-pipelines-language-server", "--stdio" },
		filetypes = { "yaml", "yml" },
		root_marker = {
			".git",
			"azure-pipelines.yml",
			"azure-pipelines.yaml",
			".azuredevops/**/.yml",
			".azuredevops/**/.yaml",
		},
		single_file_support = true,
		settings = {
			yaml = {
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	},
}
