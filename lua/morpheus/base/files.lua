return {
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    config = function()
      require('oil').setup()
      vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'Dired' })
    end,
  },
}
