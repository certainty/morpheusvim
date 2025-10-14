return {
  {
    'mfussenegger/nvim-dap',
    filetype = { 'go', 'gomod', 'ruby', 'rspec', 'lua', 'javascript', 'typescript', 'vue', 'json', 'yaml', 'scala' },
    dependencies = {},
    keys = {
      {
        '<localleader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<localleader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Set Breakpoint Condition',
      },
      {
        '<localleader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Continue',
      },
      {
        '<localleader>di',
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<localleader>do',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<localleader>dO',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<localleader>dr',
        function()
          require('dap').repl.toggle {}
        end,
        desc = 'Toggle REPL',
      },
      {
        '<localleader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Run Last',
      },
    },
  },
  {
    'igorlfs/nvim-dap-view',
    filetype = { 'go', 'gomod', 'ruby', 'rspec', 'lua', 'javascript', 'typescript', 'vue', 'json', 'yaml', 'scala' },
    keys = {
      {
        '<localleader>dv',
        function()
          require('dap-view').toggle()
        end,
        desc = 'Toggle Dap View',
      },
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
    keys = {
      {
        '<localleader>du',
        function()
          require('dapui').toggle {}
        end,
        desc = 'Toggle Dap UI',
      },
      {
        '<localleader>de',
        function()
          require('dapui').eval()
        end,
        desc = 'Dap UI Eval',
      },
      {
        '<localleader>dh',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = 'Dap UI Hover',
      },
      {
        '<localleader>df',
        function()
          local widgets = require 'dap.ui.widgets'
          widgets.centered_float(widgets.frames)
        end,
        desc = 'Dap UI Frames',
      },
      {
        '<localleader>ds',
        function()
          local widgets = require 'dap.ui.widgets'
          widgets.centered_float(widgets.scopes)
        end,
        desc = 'Dap UI Scopes',
      },
    },
    config = function(_, opts)
      local dap = require 'dap'
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
      local breakpoint_icons = {
        Breakpoint = '',
        BreakpointCondition = '',
        BreakpointRejected = '',
        LogPoint = '',
        Stopped = '',
      }

      for type, icon in pairs(breakpoint_icons) do
        local tp = 'Dap' .. type
        local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
        vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
      end

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
}
