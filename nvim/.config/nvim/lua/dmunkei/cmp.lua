local python_print_snippet_priority = function(a, b)
    return a.completion_item.label:match("^print$")
end

local cmp = require('cmp')
local cmp_keymap = require('dmunkei.cmp_keymap')


cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end
    },
    formatting = {
        format = function(entry, vim_item)
            -- Source
            vim_item.menu = (
                {
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                    nvim_lua = "[Lua]",
                })[entry.source.name]
            return vim_item
        end
    },
    mapping = cmp_keymap.mapping,
    sources = cmp.config.sources(
        {
            { name = 'nvim_lua' },
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'nvim_lsp_signature_help' }
        },
        {
            { name = 'buffer' }
        }),
    sorting = {
        comparators = {
            python_print_snippet_priority,
            -- cmp.config.compare.offset,
            -- cmp.config.compare.exact,
            -- cmp.config.compare.score,
            --
            -- cmp.config.compare.kind,
            -- cmp.config.compare.sort_text,

            -- cmp.config.compare.length,
            -- cmp.config.compare.order,
        }
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = { ghost_text = true },
})


cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({ { name = 'luasnip' }, { name = 'cmp_git' } },
        { { name = 'buffer' } })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
})

