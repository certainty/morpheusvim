local utils = require 'morpheus.utils'

return {
  'weizheheng/ror.nvim',
  enable = Morpheus.is_enabled { 'lang', 'ruby', 'ror' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  init = function()
    utils.ftcmd('RoR', 'ruby', function(ctx)
      ctx.map('n', '<localleader>:', function()
        require('ror.commands').list_commands()
      end, 'List Rails Commands')
      ctx.map('n', '<localleader>r', '<cmd>RorRun<cr>', 'Liset Rails Commands')
    end)
  end,
}
