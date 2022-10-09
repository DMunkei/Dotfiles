if vim.fn.exists(":Reload") == 0 then
    vim.cmd([[command Reload :so /home/koestler/.config/nvim/init.lua]])
end
