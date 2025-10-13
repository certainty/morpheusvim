local utils = require 'morpheus.utils'

local function addTestBindings(ctx)
  utils.log('Lets go')
  ctx.map('n', '<leader>tt', '<cmd>lua require("neotest").run.run()<cr>', { desc = 'Run' })
  ctx.map('n', '<leader>t.', '<cmd>lua require("neotest").run.run_last()<cr>', { desc = 'Run Last' })
  ctx.map('n', '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<cr>', { desc = 'Summary' })
  ctx.map('n', '[n', "<cmd>lua require('neotest').jump.prev({ status = 'failed'})<CR>", { desc = 'Next failed' })
  ctx.map('n', ']n', "<cmd>lua require('neotest').jump.next({ status = 'failed'})<CR>", { desc = 'Prev failed' })
end

return {
  'nvim-neotest/neotest',
  dependencies = {
    { 'nvim-neotest/nvim-nio' },
    {
      'fredrikaverpil/neotest-golang',
      enable = Morpheus.is_enabled { 'lang', 'go', 'test' },
      build = function()
        vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' }):wait() -- Optional, but recommended
      end,
    },
    {
      'rouge8/neotest-rust',
      enable = Morpheus.is_enabled { 'lang', 'rust', 'test' },
    },
    {
      'olimorris/neotest-rspec',
      enable = Morpheus.is_enabled { 'lang', 'ruby', 'test' },
    },
    {
      'zidhuss/neotest-minitest',
      enable = Morpheus.is_enabled { 'lang', 'ruby', 'test' },
    },
    {
      'nvim-neotest/neotest-vim-test',
      enable = Morpheus.is_enabled { 'lang', 'scala', 'test' }
    },
    {
      'vim-test/vim-test',
      enable = Morpheus.is_enabled { 'lang', 'scala', 'test' }
    }
  },
  opts = function()
    local adapters = {}
    if Morpheus.is_enabled { 'lang', 'rust', 'test' } then
      table.insert(adapters, require 'neotest-rust')
    end
    if Morpheus.is_enabled { 'lang', 'ruby', 'test' } then
      table.insert(adapters, require 'neotest-rspec')
      table.insert(adapters, require 'neotest-minitest')
    end
    if Morpheus.is_enabled { 'lang', 'go', 'test' } then
      table.insert(adapters, require 'neotest-golang' { runner = 'gotestsum' })
    end
    if Morpheus.is_enabled { 'lang', 'scala', 'test' } then
      table.insert(adapters, require 'neotest-vim-test' {
        allow_file_types = { 'scala' },
        runners = { scala = "sbt" }
      })
    end

    -- FIXME: for some reason this does not work
    vim.g["test#shell"] = "/bin/sh"
    vim.g["test#scala#runner"] = "sbt"
    vim.g["test#shell_options"] = "-f"

    return {
      adapters = adapters,
      quickfix = {
        enabled = true,
      },
    }
  end,

  init = function()
    if Morpheus.is_enabled { 'lang', 'scala', 'test' } then
      utils.ftcmd('ScalaTest', 'scala', addTestBindings)
    end

    if Morpheus.is_enabled { 'lang', 'go', 'test' } then
      utils.ftcmd('GoTest', 'go', addTestBindings)
    end

    if Morpheus.is_enabled { 'lang', 'rust', 'test' } then
      utils.ftcmd('RustTest', 'rust', addTestBindings)
    end

    if Morpheus.is_enabled { 'lang', 'ruby', 'test' } then
      utils.ftcmd('RubyTest', 'ruby', addTestBindings)
    end
  end
}
