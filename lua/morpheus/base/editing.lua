return {
  {
    'ggandor/leap.nvim',
    init = function()
      vim.keymap.set({ 'n', 'x', 'o' }, 'gj', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'gJ', '<Plug>(leap-backward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')
    end,

    config = function()
      require('leap').setup {}
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
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
