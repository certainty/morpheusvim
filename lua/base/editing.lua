return {
  {
    'allaman/emoji.nvim',
    opts = {
      enable_cmp_integration = true,
    },
  },
  {
    'echasnovski/mini.bracketed',
    version = '*',
    config = function()
      require('mini.bracketed').setup {}
    end,
  },
  {
    'echasnovski/mini.comment',
    version = '*',
    config = function()
      require('mini.comment').setup {}
    end,
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    config = function()
      require('mini.pairs').setup {}
    end,
  },
  {
    'echasnovski/mini.ai',
    version = '*',
    config = function()
      require('mini.ai').setup {}
    end,
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    config = function()
      require('mini.surround').setup {}
    end,
  },
  {
    'nvim-mini/mini.trailspace',
    version = '*',
    event = 'BufReadPost',
    config = function()
      require('mini.trailspace').setup {
        only_in_normal_buffers = true,
      }
    end,
  },

  'tpope/vim-sleuth',
}
