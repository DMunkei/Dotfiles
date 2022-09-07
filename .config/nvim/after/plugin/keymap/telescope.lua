local Remap = require("dmunkei.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<C-s>", ":Telescope ")

-- / slash searching on steroids
nnoremap("<C-_>", function()
    require('telescope.builtin').current_buffer_fuzzy_find(
        --require('telescope.themes').get_ivy() -- Need to see which one I like more...
        {
            sorting_strategy="ascending",
            prompt_position="top"
        }
    )
end)

nnoremap("<leader>gs", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end)
nnoremap("<leader>gf", function()
    require('telescope.builtin').git_files()
end)
nnoremap("<Leader>s", function()
    require('telescope.builtin').find_files()
end)

nnoremap("<leader>gw", function()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }
end)
