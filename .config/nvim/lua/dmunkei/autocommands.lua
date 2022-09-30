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

local packer_sync_group = vim.api.nvim_create_augroup("PACKER", {clear = true})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "packer.lua",
    group=packer_sync_group,
    command = 'source <afile> | PackerSync',
})

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]
