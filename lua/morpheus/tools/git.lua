return {
  {
    'nvim-mini/mini.diff',
    opts = {
      view = {
        style = 'number',
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
    keys = {
      {
        '<localleader>,vB',
        function()
          require('gitsigns').blame_line()
        end,
        desc = 'Blame Line',
        buffer = 0,
      },
      {
        '<leader>,vb',
        function()
          require('gitsigns').toggle_current_line_blame()
        end,
        desc = 'Toggle Blame Line',
        buffer = 0,
      },
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    opts = {
      integrations = {
        diffview = true,
      },
    },
    keys = {
      { '<leader>vv', '<cmd>Neogit<CR>', desc = 'Neogit' },
    },
  },
}
