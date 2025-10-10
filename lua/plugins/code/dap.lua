vim.pack.add { 'https://github.com/mfussenegger/nvim-dap.git' }
-- vim.pack.add { 'https://github.com/rcarriga/nvim-dap-ui.git' }
vim.pack.add { 'https://github.com/jay-babu/mason-nvim-dap.nvim.git' }
vim.pack.add { 'https://github.com/nvim-neotest/nvim-nio.git' }
vim.pack.add { 'https://github.com/igorlfs/nvim-dap-view.git' }

require('mason-nvim-dap').setup {
  automatic_installation = true,
  handlers = {},
}

-- require('dapui').setup {
--   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
--   controls = {
--     icons = {
--       pause = '⏸',
--       play = '▶',
--       step_into = '⏎',
--       step_over = '⏭',
--       step_out = '⏮',
--       step_back = 'b',
--       run_last = '▶▶',
--       terminate = '⏹',
--       disconnect = '⏏',
--     },
--   },
-- }

local dap = require 'dap'
-- local dapui = require 'dapui'

vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
local breakpoint_icons = vim.g.have_nerd_font
    and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
for type, icon in pairs(breakpoint_icons) do
  local tp = 'Dap' .. type
  local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

-- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
-- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
-- dap.listeners.before.event_exited['dapui_config'] = dapui.close


-- vim.keymap.set('n', '<leader>du', function()
--   dapui.toggle()
-- end, { desc = 'Toggle Dap UI' })

vim.keymap.set('n', '<leader>dd', function()
  dap.continue()
end, { desc = 'Start/Continue' })

vim.keymap.set('n', '<leader>ds', function()
  dap.step_over()
end, { desc = 'DAP Step Over' })

vim.keymap.set('n', '<leader>di', function()
  dap.step_into()
end, { desc = 'DAP Step Into' })

vim.keymap.set('n', '<leader>do', function()
  dap.step_out()
end, { desc = 'DAP Step Out' })

vim.keymap.set('n', '<leader>db', function()
  dap.toggle_breakpoint()
end, { desc = 'DAP Toggle Breakpoint' })

vim.keymap.set('n', '<leader>dB', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'DAP Set Breakpoint Condition' })

require('dap-view').setup {
  auto_toggle = true,
  follow_tab = true,
}
