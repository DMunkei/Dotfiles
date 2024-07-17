return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		vim.diagnostic.config({
			update_in_insert = false,
			float = {
				border = "single",
				style = "minimal",
			},
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
			style = "minimal",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "single",
			style = "minimal",
		})

		require("lspconfig.ui.windows").default_options = {
			border = "single",
		}

		local function diagnostics_handler(err, result, ctx)
			if err ~= nil then
				error("Failed to request diagnostics: " .. vim.inspect(err))
			end

			if result == nil then
				return
			end

			local buffer = vim.uri_to_bufnr(result.uri)
			local namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id)

			local diagnostics = vim.tbl_map(function(diagnostic)
				local resultLines = vim.split(diagnostic.message, "\n")
				local output = vim.fn.reverse(resultLines)
				return {
					bufnr = buffer,
					lnum = diagnostic.range.start.line,
					end_lnum = diagnostic.range["end"].line,
					col = diagnostic.range.start.character,
					end_col = diagnostic.range["end"].character,
					severity = diagnostic.severity,
					message = table.concat(output, "\n\n"),
					source = diagnostic.source,
					code = diagnostic.code,
				}
			end, result.diagnostics)

			vim.diagnostic.set(namespace, buffer, diagnostics)
		end

		local builtin = require("telescope.builtin")
		local lspconfig = require("lspconfig")
		--
		-- local vue_ts_plugin = "/usr/lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
		-- lspconfig.tsserver.setup({
		-- 	init_options = {
		-- 		plugins = {
		-- 			{
		-- 				name = "@vue/typescipt-plugin",
		-- 				location = vue_ts_plugin,
		-- 				languages = { "javascript", "typescript", "vue" },
		-- 			},
		-- 		},
		-- 	},
		-- 	filetypes = {
		-- 		"javascript",
		-- 		"javascriptreact",
		-- 		"javascript.jsx",
		-- 		"typescript",
		-- 		"typescriptreact",
		-- 		"typescript.tsx",
		-- 		"vue",
		-- 	},
		-- 	root_dir = function(...)
		-- 		return lspconfig.util.root_pattern(".git")(...)
		-- 	end,
		-- 	single_file_support = false,
		-- 	settings = {
		-- 		typescript = {
		-- 			inlayHints = {
		-- 				includeInlayParameterNameHints = "literal",
		-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
		-- 				includeInlayFunctionParameterTypeHints = true,
		-- 				includeInlayVariableTypeHints = false,
		-- 				includeInlayPropertyDeclarationTypeHints = true,
		-- 				includeInlayFunctionLikeReturnTypeHints = true,
		-- 				includeInlayEnumMemberValueHints = true,
		-- 			},
		-- 		},
		-- 		javascript = {
		-- 			inlayHints = {
		-- 				includeInlayParameterNameHints = "all",
		-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
		-- 				includeInlayFunctionParameterTypeHints = true,
		-- 				includeInlayVariableTypeHints = true,
		-- 				includeInlayPropertyDeclarationTypeHints = true,
		-- 				includeInlayFunctionLikeReturnTypeHints = true,
		-- 				includeInlayEnumMemberValueHints = true,
		-- 			},
		-- 		},
		-- 	},
		-- })
		lspconfig.lua_ls.setup({
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
		--
		-- local util = require("lspconfig.util")
		-- local function get_typescript_server_path(root_dir)
		-- 	local global_ts = "/usr/lib/node_modules/typescript/lib/"
		-- 	local found_ts = ""
		-- 	local function check_dir(path)
		-- 		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
		-- 		if util.path.exists(found_ts) then
		-- 			return path
		-- 		end
		-- 	end
		-- 	if util.search_ancestors(root_dir, check_dir) then
		-- 		return found_ts
		-- 	else
		-- 		return global_ts
		-- 	end
		-- end
		--
		-- lspconfig.volar.setup({
		-- 	on_new_config = function(new_config, new_root_dir)
		-- 		new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
		-- 	end,
		-- })
		-- -- Python
		-- lspconfig.ruff_lsp.setup({})
		--
		-- lspconfig.clangd.setup({})
		-- lspconfig.yamlls.setup({})
		for _, server in ipairs({
			"dockerls",
			"docker_compose_language_service",
			"html",
			"cssls",
			"bashls",
			"marksman",
			"pyright",
			"jedi_language_server",
		}) do
			lspconfig[server].setup({})
		end
		lspconfig.emmet_ls.setup({
			filetypes = {
				"css",
				"html",
				"less",
				"sass",
				"scss",
				"htmldjango",
			},
		})
		-- lspconfig.gdscript.setup({
		-- 	filetypes = { "gd", "gdscript", "gdscript3" },
		-- })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-on-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				map("gd", builtin.lsp_definitions, "[G]oto [D]ddefinition")
				map("gr", builtin.lsp_references, "[G]oto [R]eferences")
				map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", builtin.lsp_type_definitions, "Type [D]definition")
				map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]symbols")
				map("<leader>Ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ssymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
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

				if client.name == "rust" then
					local rt = require("rust-tools")
					-- Hover actions
					vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
					-- Code action groups
					vim.keymap.set("n", "<Leader>A", rt.code_action_group.code_action_group, { buffer = bufnr })
				end

				-- In here you can run any setup code you want to apply to all your language servers.
				-- For server specific setups, see `on_attach` for lspconfig

				if client.name == "ruff_lsp" then
					client.server_capabilities.hoverProvider = false
				end

				if client.name == "typescript-tools" then
					client.server_capabilities.diagnosticsProvider = false
				end

				if client.name == "pyright" then
					client.server_capabilities.hoverProvider = false
					client.server_capabilities.renameProvider = false
					client.server_capabilities.completionProvider = false
				end

				if client.name == "jedi_language_server" then
					client.server_capabilities.definitionProvider = false
				end
			end,
		})
	end,
}
