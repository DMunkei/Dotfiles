vim.api.nvim_create_user_command("Xcolor", function()
  local Task = require("plenary.job")
  Task:new({
    "xcolor",
    on_exit = vim.schedule_wrap(function(self, code, _)
      if code ~= 0 then
        vim.notify("Could not run xcolor.")
        return
      end
      local result = self:result()
      vim.notify("Copied " .. result[1] .. " into +.")
      vim.fn.setreg("+", result)
    end)
  }):start()
end, {})
