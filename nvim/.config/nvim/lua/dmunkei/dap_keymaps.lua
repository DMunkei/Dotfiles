local dap = require("dap")
local dapui = require("dapui")
local remap = require("dmunkei.keymap")
local nnoremap = remap.nnoremap

dapui.setup({
  icons = { expanded = "", collapsed = "" },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open(1)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

nnoremap("<leader>dl", function()
    dapui.toggle(1)
end)

nnoremap("<leader>db", function()
    dapui.toggle(2)
end)

nnoremap("<leader>dt", function()
    dapui.toggle(1)
    dapui.toggle(2)
end)

nnoremap("<leader><leader>", function()
    dap.close()
end)

nnoremap("<Up>", function()
    dap.continue()
end)
nnoremap("<Down>", function()
    dap.step_over()
end)
nnoremap("<Right>", function()
    dap.step_into()
end)
nnoremap("<Left>", function()
    dap.step_out()
end)
nnoremap("<leader>b", function()
    dap.toggle_breakpoint()
end)
nnoremap("<leader>B", function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
nnoremap("<leader>rc", function()
    dap.run_to_cursor()
end)
