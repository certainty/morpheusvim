return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  config = function()
    require('chatgpt').setup {
      api_key_cmd = 'op read op://personal/openai-neovim/credential --no-newline',
    }
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim', -- optional
    'nvim-telescope/telescope.nvim',
  },
}
