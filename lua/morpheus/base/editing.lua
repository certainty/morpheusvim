return {
  {
    'echasnovski/mini.trailspace',
    version = false,
    config = function()
      require('mini.trailspace').setup {
        only_in_normal_buffers = true,
      }
    end,
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
  'tpope/vim-sleuth',
}
