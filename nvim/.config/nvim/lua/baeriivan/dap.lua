local ok, dap = pcall(require, "dap")
if not ok then return end

local codicons = require('codicons')

local dapui = require("dapui")

dapui.setup({
  controls = {
    icons = {
      -- disconnect = codicons.get('debug-disconnect', 'icon'),
      pause = "",
      play = "",
      run_last = "",
      step_back = "",
      step_into = "",
      step_out = "",
      step_over = "",
      terminate = ""
    }
  },
  icons = {
    collapsed = "",
    current_frame = "",
    expanded = ""
  },

})

require("nvim-dap-virtual-text").setup()


-- dap.set_log_level("TRACE")
dap.set_log_level("DEBUG")


dap.adapters.python = {
  type = 'executable',
  command = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/debugpy/venv/bin/python',
  args = { '-m', 'debugpy.adapter' },
}
dap.adapters.chrome = {
  type = 'executable',
  command = 'node',
  -- args = {os.getenv('HOME') .. '/vscode-node-debug2/out/src/nodeDebug.js'},
  args = {os.getenv('HOME') .. '/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js'},
}
-- dap.adapters.node2 = {
--   type = 'executable',
--   command = 'node',
--   args = { os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
-- }


dap.configurations.python = {
  {
    type = 'python',
    name = "Launch file",
    request = 'launch',
    program = "${file}",
  },
}
dap.configurations.typescript = {
  {
    name = "Debug (Attach) - Remote",
    type = "chrome",
    request = "attach",
    -- program = "${file}",
    -- cwd = vim.fn.getcwd(),
    sourceMaps = true,
    --      reAttach = true,
    trace = true,
    -- protocol = "inspector",
    hostName = "localhost:4321",
    port = 9222,
    webRoot = "${workspaceFolder}"
  }
  -- {
  --   type = "node2",
  --   name = "node attach",
  --   request = "attach",
  --   program = "${file}",
  --   cwd = vim.fn.getcwd(),
  --   sourceMaps = true,
  --   protocol = "inspector",
  --   port = 9229,
  --   processId = require'dap.utils'.pick_process,
  -- },
  -- {
  --   type = "node2",
  --   name = "Attach to url with files served from ./out",
  --   request = "attach",
  --   port = 9229,
  --   url = "localhost:4200/",
  --   webRoot = "${workspaceFolder}/out"
  -- },
  -- {
    --
    -- name = 'Ng launch',
    -- type = 'node2',
    -- request = 'launch',
    -- cwd = vim.fn.getcwd(),
    -- protocol = 'inspector',
    -- program = "${file}",
    -- sourceMaps = true,
    --
    -- url = "http://localhost:4200",
    -- webRoot = "${workspaceFolder}",
    -- sourceMaps = true,
    -- program = '${file}',
    -- debugServer = 45635,
    -- console = 'integratedTerminal',
    -- outFiles = {"${workspaceFolder}/build/**/*.js"},
  -- },
  -- {
  --   name = 'Ng attach',
  --   type = 'node2',
  --   request = 'attach',
  --   cwd = vim.fn.getcwd(),
  --   protocol = 'inspector',
  --   port = 9222,
  --   -- url = "http://localhost:4200",
  --   webRoot = "${workspaceFolder}",
  --   processId = require'dap.utils'.pick_process,
  --   -- program = '${file}',
  --   -- debugServer = 45635,
  --   -- console = 'integratedTerminal',
  --   -- sourceMaps = true,
  --   -- outFiles = {"${workspaceFolder}/build/**/*.js"},
  -- },
}


vim.keymap.set("n", "<F2>", ":lua require'dapui'.toggle()<CR>")
vim.keymap.set("n", "<F3>", ":DapTerminate<CR>")
vim.keymap.set("n", "<F4>", ":DapRestartFrame<CR>")
vim.keymap.set("n", "<F5>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<F6>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F7>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F8>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))()<CR>")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end
