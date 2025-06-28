return {
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup()
      require('telescope').load_extension 'refactoring'

      vim.keymap.set({ 'n', 'x' }, '<localleader>rr', function()
        require('telescope').extensions.refactoring.refactors()
      end)
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'jfpedroza/neotest-elixir',
      'nvim-neotest/neotest-jest',
      'fredrikaverpil/neotest-golang',
      'rouge8/neotest-rust',
      'stevanmilic/neotest-scala',
      'olimorris/neotest-rspec',
      'zidhuss/neotest-minitest',
    },
    init = function()
      local test_map = require('base.keymap').group('n', 'test')
      test_map('t', '<cmd>lua require("neotest").run.run()<cr>', 'Run')
      test_map('.', '<cmd>lua require("neotest").run.run_last()<cr>', 'Run Last')
      test_map('s', '<cmd>lua require("neotest").summary.toggle()<cr>', 'Summary')

      vim.keymap.set('n', '[n', "<cmd>lua require('neotest').jump.prev({ status = 'failed'})<CR>", { desc = 'Next failed' })
      vim.keymap.set('n', ']n', "<cmd>lua require('neotest').jump.next({ status = 'failed'})<CR>", { desc = 'Prev failed' })
    end,
    opts = function()
      return {
        -- your neotest config here
        adapters = {
          require 'neotest-elixir',
          require 'neotest-golang' {},
          require 'neotest-jest',
          require 'neotest-rust',
          require 'neotest-scala',
          require 'neotest-rspec',
          require 'neotest-minitest',
        },
      }
    end,
    config = function(_, opts)
      require('neotest').setup(opts)
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
