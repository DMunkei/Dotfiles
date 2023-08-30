local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})



vim.api.nvim_create_autocmd("LspAttach", {
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

    if client.name == "pyright" then
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.renameProvider = false
    end

    if client.name == "jedi_language_server" then
        client.server_capabilities.definitionProvider = false
    end

     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
     vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
     vim.keymap.set('n', 'K', vim.lsp.buf.hover)
     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
     vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help)
     vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition)
     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

     vim.keymap.set({'i','n'}, '<M-CR>', vim.lsp.buf.code_action)
     vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {desc = '[G]oto [R]eferences'})
     vim.keymap.set('n', '<leader>l', vim.lsp.buf.format)
  end,
})

local packer_sync_group = vim.api.nvim_create_augroup("PACKER", {clear = true})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "packer.lua",
    group=packer_sync_group,
    command = 'source <afile>',
})

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]
