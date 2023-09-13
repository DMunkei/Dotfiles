return {
	"neovim/nvim-lspconfig",

	config = function()
		local lspconfig = require("lspconfig")

		lspconfig.tsserver.setup({})
		lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"

                    },
                    diagnostics = {
                        globals = {"vim", "use", "app"},
                        disable = {"lowercase-global"}
                    },
                },
            },
        })

		-- Another cool thing is `:help LspAttach`
		--   (this is an autocommand, see `:help autocmd` and `:help nvim_create_autocmd`)
		--
		-- This autocmd will run when any of your language servers attaches, so you can put LSP specific
		-- configuration like keymaps there
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-on-attach", { clear = true }),
			callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)

                if client.name == "rust" then
                    local rt = require("rust-tools")
                    -- Hover actions
                    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                    -- Code action groups
                    vim.keymap.set("n", "<Leader>A", rt.code_action_group.code_action_group, { buffer = bufnr })
                end

				-- In here you can run any setup code you want to apply to all your language servers.
				-- For server specific setups, see `on_attach` for lspconfig

                if client.name == "pyright" then
                    client.server_capabilities.hoverProvider = false
                    client.server_capabilities.renameProvider = false
                end

                if client.name == "jedi_language_server" then
                    client.server_capabilities.definitionProvider = false
                end

                vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition)
                vim.keymap.set('n', 'rN', vim.lsp.buf.rename)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
                vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help)

                vim.keymap.set({ 'i', 'n' }, '<M-CR>', vim.lsp.buf.code_action)
                vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
                vim.keymap.set('n', '<leader>l', vim.lsp.buf.format)
			end,
		})
	end,
}
