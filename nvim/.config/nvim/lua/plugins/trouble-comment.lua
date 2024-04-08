return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = {"BufReadPre", "BufNewFile"},
  config = function ()
    local todo_comments = require 'todo-comments'
    vim.keymap.set('n',"]t", function() require("todo-comments").jump_next() end, {desc = "Next todo comment" })
    vim.keymap.set('n',  "[t", function() require("todo-comments").jump_prev() end, {desc = "Previous todo comment"} )
    todo_comments.setup()
 end
}
