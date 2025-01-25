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
    'stevearc/overseer.nvim',
    opts = {},
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
    opts = {
      task_list = {
        direction = 'right',
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
    keys = {
      {
        '<leader>rr',
        '<cmd>CompilerOpen<cr>',
        { desc = 'Open' },
      },
      {
        '<leader>r.',
        '<cmd>CompilerRedo<cr>',
        { desc = 'Redo' },
      },
      {
        '<leader>rs',
        '<cmd>CompilerStop<cr>',
        { desc = 'Stop' },
      },
      {
        '<leader>rt',
        '<cmd>CompilerToggleResults<cr>',
        { desc = 'Toggle Results' },
      },
    },
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
    keys = {
      {
        '<leader>tt',
        '<cmd>lua require("neotest").run.run()<cr>',
        { desc = 'Run' },
      },
      {
        '<leader>t.',
        '<cmd>lua require("neotest").run.run_last()<cr>',
        { desc = 'Run Last' },
      },
      {
        '<leader>ts',
        '<cmd>lua require("neotest").summary.toggle()<cr>',
        { desc = 'Summary' },
      },
      {
        '[n',
        "<cmd>lua require('neotest').jump.prev({ status = 'failed'})<CR>",
        { desc = 'Next failed' },
      },
      {
        ']n',
        "<cmd>lua require('neotest').jump.next({ status = 'failed'})<CR>",
        { desc = 'Prev failed' },
      },
    },
    opts = function()
      return {
        -- your neotest config here
        adapters = {
          require 'neotest-elixir',
          require 'neotest-golang',
          require 'neotest-jest',
          require 'neotest-rust',
          require 'neotest-scala',
          require 'neotest-rspec',
          require 'neotest-minitest',
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
