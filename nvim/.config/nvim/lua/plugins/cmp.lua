return {
    "hrsh7th/nvim-cmp",

    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-omni",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-emoji",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "f3fora/cmp-spell",
    },
    config = function()
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
            mapping = cmp.mapping.preset.insert({
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<C-y>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                }),
                ['<C-Space>'] = cmp.mapping(
                    cmp.mapping.complete(), { "i", "c" }
                ),
            }),
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
    end,
}
