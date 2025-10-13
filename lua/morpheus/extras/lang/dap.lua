local utils = require 'morpheus.utils'

local function dapKeyBinds(ctx)
  ctx.map('n', '<localleader>,b', require('dap').toggle_breakpoint, { noremap = true, desc = 'Breakpoint' })
  ctx.map('n', '<localleader>,B', function()
    require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Breakpoint*' })
  ctx.map('n', '<leader>dd', require('dap').continue, { noremap = true, desc = 'Continue' })
  ctx.map('n', '<leader>do', require('dap').step_over, { noremap = true, desc = 'Step Over' })
  ctx.map('n', '<leader>di', require('dap').step_into, { noremap = true, desc = 'Step Into' })
  ctx.map('n', '<leader>dU', require('dapui').toggle, { noremap = true, desc = 'Dap UI' })
  ctx.map('n', '<leader>du', '<cmd>DapViewOpen<cr>', { noremap = true, desc = 'Dap View Open' })
  ctx.map('n', '<leader>dx', '<cmd>DapViewClose<cr>', { noremap = true, desc = 'Dap View Close' })
end

local function setupDapUI(dap)
  local dapui = require 'dapui'
  dapui.setup()

  dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
  end

  dapui.setup {
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }
  vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#f11900' })
  vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
  local breakpoint_icons = { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped =
  '' }

  for type, icon in pairs(breakpoint_icons) do
    local tp = 'Dap' .. type
    local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
  end

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close
end

return {
  'mfussenegger/nvim-dap',
  lazy = false,
  dependencies = {
    { 'rcarriga/nvim-dap-ui' },
    { 'igorlfs/nvim-dap-view' },
    { 'nvim-neotest/nvim-nio' },
    { 'suketa/nvim-dap-ruby',              enable = Morpheus.is_enabled { 'lang', 'ruby', 'dap' } },
    { 'leoluz/nvim-dap-go',                enable = Morpheus.is_enabled { 'lang', 'go', 'dap' } },
    { 'jbyuki/one-small-step-for-vimkind', enable = Morpheus.is_enabled { 'lang', 'lua', 'dap' } },
  },
  config = function()
    local dap = require 'dap'

    setupDapUI(dap)

    -- Adapters
    if Morpheus.is_enabled { 'lang', 'ruby', 'dap' } then
      require('dap-ruby').setup()
    end

    if Morpheus.is_enabled { 'lang', 'go', 'dap' } then
      require('dap-go').setup()
    end

    if Morpheus.is_enabled { 'lang', 'lua', 'dap' } then
      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = 'Attach to running Neovim instance',
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
      end
    end
  end,
  init = function()
    local dap = require 'dap'

    if Morpheus.is_enabled { 'lang', 'go', 'dap' } then
      utils.ftcmd('GoDap', 'go', function(ctx)
        dapKeyBinds(ctx)
        ctx.map('n', '<leader>dl', function()
          require('osv').launch { port = 8086 }
        end, { noremap = true })

        ctx.map('n', '<leader>dw', function()
          local widgets = require 'dap.ui.widgets'
          widgets.hover()
        end)

        ctx.map('n', '<leader>df', function()
          local widgets = require 'dap.ui.widgets'
          widgets.centered_float(widgets.frames)
        end)
      end)
    end

    if Morpheus.is_enabled { 'lang', 'scala', 'dap' } then
      utils.ftcmd('ScalaDap', 'scala', function(ctx)
        dapKeyBinds(ctx)
      end)

      dap.configurations.scala = {
        {
          type = 'scala',
          request = 'launch',
          name = 'RunOrTest',
          metals = {
            runType = 'runOrTestFile',
          },
        },
        {
          type = 'scala',
          request = 'launch',
          name = 'RunOrTest with Args',
          metals = {
            runType = 'runOrTestFile',
            args = function()
              local input = vim.fn.input 'Program arguments: '
              if input == '' then
                return {}
              end
              local args = {}
              for arg in input:gmatch '%S+' do
                table.insert(args, arg)
              end
              return args
            end,
          },
        },
        {
          type = 'scala',
          request = 'launch',
          name = 'Run Specific Main Class',
          metals = {
            runType = 'run',
            mainClass = function()
              return vim.fn.input 'Main class (e.g., com.example.Main): '
            end,
            args = function()
              local input = vim.fn.input 'Program arguments: '
              if input == '' then
                return {}
              end
              local args = {}
              for arg in input:gmatch '%S+' do
                table.insert(args, arg)
              end
              return args
            end,
          },
        },
        {
          type = 'scala',
          request = 'launch',
          name = 'Test Target',
          metals = {
            runType = 'testTarget',
          },
        },
        {
          type = 'scala',
          request = 'launch',
          name = 'Test Specific Class',
          metals = {
            runType = 'testTarget',
            testClass = function()
              return vim.fn.input 'Test class name: '
            end,
          },
        },
        {
          name = 'Debug Attach (5005)',
          type = 'scala',
          request = 'attach',
          hostName = '127.0.0.1',
          port = function()
            return tonumber(vim.fn.input('Port: ', '5005'))
          end,
          metals = {},
        },
      }
    end

    if Morpheus.is_enabled { 'lang', 'ruby', 'dap' } then
      utils.ftcmd('RubyDap', 'ruby', function(ctx)
        dapKeyBinds(ctx)
      end)
    end

    if Morpheus.is_enabled { 'lang', 'lua', 'dap' } then
      utils.ftcmd('LuaDap', 'lua', function(ctx)
        dapKeyBinds(ctx)
      end)
    end
  end,
}
