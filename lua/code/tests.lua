return {
  'nvim-neotest/neotest',
  dependencies = {
    {
      'fredrikaverpil/neotest-golang',
      build = function()
        vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' }):wait() -- Optional, but recommended
      end,
    },
    'rouge8/neotest-rust',
    'olimorris/neotest-rspec',
    'zidhuss/neotest-minitest',
  },
  keys = {
    { '<leader>tt', '<cmd>lua require("neotest").run.run()<cr>', desc = 'Run' },
    { '<leader>t.', '<cmd>lua require("neotest").run.run_last()<cr>', desc = 'Run Last' },
    { '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<cr>', desc = 'Summary' },
    { '[n', "<cmd>lua require('neotest').jump.prev({ status = 'failed'})<CR>", desc = 'Next failed', mode = 'n' },
    { ']n', "<cmd>lua require('neotest').jump.next({ status = 'failed'})<CR>", desc = 'Prev failed', mode = 'n' },
  },
  opts = function()
    return {
      adapters = {
        require 'neotest-golang' { runner = 'gotestsum' },
      },
    }
  end,
}
