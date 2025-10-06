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
    opts = {},
  },
  {
    'echasnovski/mini.comment',
    version = '*',
    opts = {},
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    opts = {},
  },
  {
    'echasnovski/mini.ai',
    version = '*',
    opts = {},
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    opts = {},
  },
  {
    'nvim-mini/mini.trailspace',
    version = '*',
    event = 'BufReadPost', -- this is important to make sure this does not mess with snacks.dashboard
    opts = { only_in_normal_buffers = true },
  },
  'tpope/vim-sleuth',
}
