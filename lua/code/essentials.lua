return {
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup()
      require('telescope').load_extension 'refactoring'

      vim.keymap.set({ 'n', 'x' }, '<localleader>rr', function()
        require('telescope').extensions.refactoring.refactors()
      end)
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup { signs = false }
    end,
  },
}
