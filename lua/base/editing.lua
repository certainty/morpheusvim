return {
  {
    'allaman/emoji.nvim',
    opts = {
      enable_cmp_integration = true,
    },
  },
  {
    'smoka7/multicursors.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvimtools/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    init = function()
      local cursor_map = require('base.keymap').at_point { 'v', 'n' }

      cursor_map('%', '<cmd>MCstart</cr>', 'Start multicursor')
    end,
    config = function()
      require('multicursors').setup {
        hint_config = {
          float_opts = {
            border = 'rounded',
          },
          position = 'bottom-right',
        },
        generate_hints = {
          normal = true,
          insert = true,
          extend = true,
          config = {
            column_count = 1,
          },
        },
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
