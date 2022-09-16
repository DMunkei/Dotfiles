local nnoremap = require("dmunkei.keymap").nnoremap

nnoremap("<C-s>", ":Telescope ")

-- / slash searching on steroids
nnoremap("<C-_>", function()
    require('telescope.builtin').current_buffer_fuzzy_find(
        --require('telescope.themes').get_ivy() -- Need to see which one I like more...
        {
            sorting_strategy="ascending",
            layout_config = { prompt_position="top" },
        }
    )
end)

nnoremap("<leader>fs", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end)
nnoremap("<leader>gf", function()
    require('telescope.builtin').git_files()
end)
nnoremap("<leader>ff", function()
    require('telescope.builtin').find_files()
end)

nnoremap("<leader>S", function()
    require('telescope.builtin').live_grep()
end)

nnoremap("<leader>gw", function()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }
end)

