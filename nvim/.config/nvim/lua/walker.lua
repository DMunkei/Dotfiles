local Task = require("plenary.job")
local Menu = require("nui.menu")

local defaults = {
  menu = {
    position = "50%",
    size = {
      width = 25,
      height = 5,
    },
    border = {
      style = "solid",
      text = {
        top = "Walk",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:NormalFloat",
    },
  },
}

local make_menu = function(file, items, options)
  if items == nil then items = {} end
  if options == nil then options = {} end

  options = vim.tbl_deep_extend("keep", options, defaults.menu)
  local extension = vim.fn.fnamemodify(file, ":e")
  if extension == "" then extension = "txt" else extension = extension end

  local buffer = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buffer, "filetype", extension)
  vim.api.nvim_win_set_buf(0, buffer)
  return Menu(options, {
    lines = vim.tbl_map(Menu.item, items),
    max_width = 20,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>" },
      submit = { "<CR>", "<Space>" },
    },
    on_change = function(self)
      -- this is blocking
      local replaced = vim.fn.system("git show " .. tostring(self.text) .. ":" .. tostring(file))
      ---@diagnostic disable-next-line: cast-local-type
      replaced = vim.split(replaced, "\n")
      return vim.api.nvim_buf_set_lines(buffer, 0, -1, false, replaced)
    end,
    on_submit = function(self) -- see if you want to checkout that branch/hash
      local choices = { "Yes", "No", "Cancel" }
      local on_choice = function(choice)
        if "Yes" == choice then
          if vim.fn.system("git checkout " .. tostring(self.text)) then
            vim.notify("Checked out " .. tostring(self.text) .. "!")
          end
        elseif "No" == choice then
          return vim.api.nvim_buf_delete(buffer, { force = true })
        else
          vim.notify("Cancelled.")
        end
      end
      vim.ui.select(choices, { prompt = "Are you sure?" }, on_choice)
    end,
    on_close = function() vim.api.nvim_buf_delete(buffer, { force = true }) end,
  })
end

return {
  walk = function(file)
    if file == nil then file = vim.fn.expand("%") end
    ---@diagnostic disable-next-line: missing-fields
    Task:new({
      "git",
      "log",
      "--pretty=format:%h",
      "--no-notes",
      "--no-color",
      "--no-decorate",
      "--ignore-submodules",
      file,
      on_exit = function(self, code)
        if code ~= 0 then
          return
        end
        return vim.schedule(function()
          return make_menu(file, self:result()):mount()
        end)
      end,
    }):start()
  end,
}
