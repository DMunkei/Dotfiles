return {
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
