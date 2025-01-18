return {
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
    },
  },
  {
    'zeioth/compiler.nvim',
    cmd = {
      'CompilerOpen',
      'CompilerToggleResults',
      'CompilerRedo',
      'CompilerStop',
    },
    dependencies = { 'stevearc/overseer.nvim' },
    opts = {},
  },

  {
    'nvim-neotest/neotest',
    dependencies = {
      'jfpedroza/neotest-elixir',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-jest',
      'rouge8/neotest-rust',
      'stevanmilic/neotest-scala',
      'olimorris/neotest-rspec',
    },
    opts = function()
      return {
        -- your neotest config here
        adapters = {
          require 'neotest-elixir',
          require 'neotest-go',
          require 'neotest-jest',
          require 'neotest-rust',
          require 'neotest-scala',
          require 'neotest-rspec',
        },
      }
    end,
    config = function(_, opts)
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace 'neotest'
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)

      require('neotest').setup(opts)

      local nt = require 'neotest'
      -- set keys for neotest commands
      vim.keymap.set('n', '<leader>tt', nt.run.run, { desc = 'Run' })
      vim.keymap.set('n', '[n', "<lua> require('neotest').jump.prev({ status = 'failed'})<CR>", { desc = 'Run' })
      vim.keymap.set('n', ']n', "<lua> require('neotest').jump.next({ status = 'failed'})<CR>", { desc = 'Run' })
      vim.keymap.set('n', '<leader>tl', nt.run.run_last, { desc = 'Run Last' })
      vim.keymap.set('n', '<leader>ts', nt.summary.toggle, { desc = 'Summary' })
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup { signs = false }
    end,
  },
}
