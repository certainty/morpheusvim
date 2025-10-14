--vim.lsp.enable 'solargraph'
vim.lsp.enable 'ruby-lsp'

return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'olimorris/neotest-rspec',
      'zidhuss/neotest-minitest',
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      vim.list_extend(opts.adapters, {
        require 'neotest-rspec',
        require 'neotest-minitest',
      })
    end,
    keys = {
      {
        '<localleader>tt',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run Nearest Test',
      },
      {
        '<localleader>tT',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run Current File Tests',
      },
      {
        '<localleader>ta',
        function()
          require('neotest').run.attach()
        end,
        desc = 'Attach to Nearest Test',
      },
      {
        '<localleader>dt',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug Nearest Test',
      },
      {
        '<localleader>to',
        function()
          require('neotest').output.open { enter = true }
        end,
        desc = 'Open Test Output',
      },
      {
        '<localleader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle Test Summary',
      },
    },
  },
  {
    'suketa/nvim-dap-ruby',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('dap-ruby').setup()
    end,
  },

  {
    'weizheheng/ror.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'rails' },
        callback = function(evt)
          vim.keymap.set('n', '<localleader>:', function()
            require('ror').list_commands()
          end, { desc = 'List Rails Commands', buffer = evt.buf })
          vim.keymap.set('n', '<localleader>r', function()
            require('ror').run_command()
          end, { desc = 'Run Rails Command', buffer = evt.buf })
        end,
      })
    end,
  },
}
