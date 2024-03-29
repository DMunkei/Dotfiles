local handlers = require('nvim-autopairs.completion.handlers')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {
    filetypes = {
        ["*"] = {
            ["("] = {
                kind = {
                    cmp.lsp.CompletionItemKind.Function,
                    cmp.lsp.CompletionItemKind.Method
                },
                handler = handlers["*"]
            }
        }
    }
})
