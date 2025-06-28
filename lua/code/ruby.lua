return {
  'weizheheng/ror.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'ruby',
      callback = function(event)
        local ror_map = require('base.keymap').local_group('n', event.buf, ':')

        ror_map(':', ":lua require('ror.commands').list_commands()<CR>", 'List Rails Commands')
        ror_map('r', '<cmd>RorRun<CR>', 'Run Ruby File')
      end,
    })
  end,
  config = function()
    require('ror').setup {
      -- Add your configuration here
      -- For example:
      -- default_ruby_version = '3.0.0',
      -- default_rails_version = '6.1.0',
      -- etc.
    }
  end,
}
