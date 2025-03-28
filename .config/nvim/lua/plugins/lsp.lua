return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		"saghen/blink.cmp",
	},
	config = function()
		vim.diagnostic.config({
			update_in_insert = false,
			float = {
				border = "rounded",
				style = "minimal",
			},
		})

		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false,
			signs = true,
			underline = true,
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
			style = "minimal",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
			style = "minimal",
		})

		require("lspconfig.ui.windows").default_options = {
			border = "rounded",
		}
		--
		local builtin = require("telescope.builtin")
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						globals = { "vim", "use", "app", "api" },
						disable = { "lowercase-global" },
					},
				},
			},
		})
		-- Python
		lspconfig.ruff.setup({
			init_options = {
				settings = {
					-- Any extra CLI arguments for `ruff` go here.
					lint = { enabled = true },
					args = {
						-- line-length = 180
						-- [lint]
						-- preview=true
						-- extend-select = ["E501", "N", "R", "I"]
					},
				},
			},
		})

		lspconfig.basedpyright.setup({
			capabilities = capabilities,
			settings = {
				basedpyright = {
					disableOrganizeImports = true,
					analysis = {
						diagnosticMode = "workspace",
						typeCheckingMode = "standard",
						diagnosticSeverityOverrides = {
							reportIncompatibleVariableOverride = "none",
							reportIncompatibleMethodOverride = "none",
							reportAssignmentType = "none",
						},
					},
				},
			},
		})
		for _, server in ipairs({
			"dockerls",
			"docker_compose_language_service",
			"ts_ls",
			"html",
			"cssls",
			"bashls",
			"marksman",
			"jedi_language_server",
			"sqlls",
		}) do
			lspconfig[server].setup({ capabilities = capabilities })
		end
		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			filetypes = {
				"css",
				"html",
				"less",
				"sass",
				"scss",
				"htmldjango",
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-on-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				map("gd", builtin.lsp_definitions, "[G]oto [D]ddefinition")
				vim.api.nvim_set_keymap(
					"n",
					"rn",
					"<cmd>lua vim.lsp.buf.rename()<CR>",
					{ noremap = true, silent = true, desc = "Rename" }
				)
				-- map("rn", vim.lsp.buf.rename, "Rename", { noremap = true, silent = true })
				map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", builtin.lsp_type_definitions, "Type [D]definition")
				map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]symbols")
				map("<leader>Ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ssymbols")
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
				-- map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)

				local bufnr = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				--- @param method string
				local supports_method = function(method)
					return client.supports_method(method, { bufnr = event.buf })
				end
				function augroup(name, options)
					options = vim.F.if_nil(options, {})
					options = vim.tbl_deep_extend("force", { clear = true }, options)

					return vim.api.nvim_create_augroup(name, options)
				end

				if supports_method("textDocument/documentHighlight") then
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = augroup("DMunkei" .. tostring(event.buf)),
						buffer = event.buf,
						callback = function(event)
							local ok, treesitter = pcall(require, "nvim-treesitter.ts_utils")
							if not ok then
								return
							end

							local current_node = treesitter.get_node_at_cursor()

							if not current_node then
								vim.lsp.buf.clear_references()
								return
							end

							local node_text = vim.treesitter.get_node_text(current_node, event.buf)

							if CURRENT_NODE == node_text then
								return
							end

							CURRENT_NODE = node_text
							vim.lsp.buf.clear_references()

							local node_type = current_node:type()

							if node_type == "identifier" or node_type == "property_identifier" then
								vim.lsp.buf.document_highlight()
							end
						end,
					})
				end
				if client == nil then
					return
				end

				if client.name == "ruff" then
					client.server_capabilities.hoverProvider = false
				end

				if client.name == "basedpyright" or client.name == "pyright" then
					-- client.server_capabilities.hoverProvider = false
					client.server_capabilities.renameProvider = false
					-- client.server_capabilities.completionProvider = false
				end

				if client.name == "jedi_language_server" then
					client.server_capabilities.definitionProvider = false
					client.server_capabilities.completionProvider = false
					client.server_capabilities.referencesProvider = false
				end
			end,
		})
	end,
}
