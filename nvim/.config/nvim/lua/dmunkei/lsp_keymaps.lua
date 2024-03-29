local nnoremap = require('dmunkei.keymap').nnoremap
local inoremap = require('dmunkei.keymap').inoremap

local M = {}

 local opts = {noremap = true, silent = true}
 nnoremap('<leader>E', vim.diagnostic.open_float, opts)
 nnoremap('[d', vim.diagnostic.goto_prev, opts)
 nnoremap(']d', vim.diagnostic.goto_next, opts)
 nnoremap('<leader>q', vim.diagnostic.setloclist, opts)

 local on_attach = function(client, bufnr)
     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

     local bufopts = {noremap = true, silent = true, buffer = bufnr}
     nnoremap('gD', vim.lsp.buf.declaration, bufopts)
     nnoremap('gd', vim.lsp.buf.definition, bufopts)
     nnoremap('K', vim.lsp.buf.hover, bufopts)
     nnoremap('gi', vim.lsp.buf.implementation, bufopts)
     inoremap('<C-k>', vim.lsp.buf.signature_help, bufopts)

     nnoremap('<leader>D', vim.lsp.buf.type_definition, bufopts)
     nnoremap('<leader>rn', vim.lsp.buf.rename, bufopts)
     nnoremap('<leader>ca', vim.lsp.buf.code_action, bufopts)
     vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {desc = '[G]oto [R]eferences'})
     nnoremap('<leader>l', vim.lsp.buf.format, bufopts)
 end

 M.attach = on_attach

 -- return M
