local dap = require('dap')
require("nvim-dap-virtual-text").setup()
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
require('dmunkei.dap_keymaps')


vim.fn.sign_define('DapBreakpoint', {text='💀', texthl='', linehl='', numhl=''})


dap.adapters.godot = {
  type = "server",
  host = '127.0.0.1',
  port = 6006,
}

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  }
}
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    name = "lldb"
}

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
                                'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},

        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        runInTerminal = false
    }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

table.insert(require('dap').configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'django',
  program = '${workspaceFolder}/manage.py',
  django = false,
  console = 'internalConsole',
  justMyCode = true,
  args ={'runserver', '--noreload'},
  env = {PYDEVD_WARN_SLOW_RESOLVE_TIMEOUT="10"},
  -- python = python_path()
  -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
})
