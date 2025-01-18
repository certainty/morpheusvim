return {
  {
    'echasnovski/mini.files',
    version = '*',
    init = function()
      vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<CR>', { desc = 'Dired' })
    end,
    config = function()
      require('mini.files').setup {}
    end,
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    config = function()
      require('oil').setup()
      -- vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'Dired' })
    end,
  },
}
