return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  config = function()
    require('chatgpt').setup {
      -- local secret = require('op.api').item.get('personal/openai-neovim', 'credential'),
    }
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim', -- optional
    'nvim-telescope/telescope.nvim',
  },
}
