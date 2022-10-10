local nnoremap = require('dmunkei.keymap').nnoremap
local inoremap = require('dmunkei.keymap').inoremap

local M = {}

 local opts = {noremap = true, silent = true}
 nnoremap('<space>E', vim.diagnostic.open_float, opts)
 nnoremap('[d', vim.diagnostic.goto_prev, opts)
 nnoremap(']d', vim.diagnostic.goto_next, opts)
 nnoremap('<space>q', vim.diagnostic.setloclist, opts)

 local on_attach = function(client, bufnr)
     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

     local bufopts = {noremap = true, silent = true, buffer = bufnr}
     nnoremap('gD', vim.lsp.buf.declaration, bufopts)
     nnoremap('gd', vim.lsp.buf.definition, bufopts)
     nnoremap('K', vim.lsp.buf.hover, bufopts)
     nnoremap('gi', vim.lsp.buf.implementation, bufopts)
     inoremap('<C-k>', vim.lsp.buf.signature_help, bufopts)

     nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts)
     nnoremap('<space>rn', vim.lsp.buf.rename, bufopts)
     nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts)
     nnoremap('gr', vim.lsp.buf.references, bufopts)
     nnoremap('<space>l', vim.lsp.buf.format, bufopts)
 end

 M.attach = on_attach

 return M
