return {
  'nvim-mini/mini.bracketed',
  dependencies = {
    'nvim-mini/mini.comment',
    'nvim-mini/mini.pairs',
    'nvim-mini/mini.ai',
    'nvim-mini/mini.align',
    'nvim-mini/mini.keymap',
    'nvim-mini/mini.surround',
    'nvim-mini/mini.operators',
    'nvim-mini/mini.jump',
    'nvim-mini/mini.jump2d',
  },
  lazy = false,
  config = function()
    require('mini.bracketed').setup()
    require('mini.comment').setup()
    require('mini.pairs').setup()
    require('mini.operators').setup()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.surround').setup()
    require('mini.jump').setup()
    require('mini.jump2d').setup()

    require('mini.keymap').setup()
    local map_multistep = require('mini.keymap').map_multistep
    local map_combo = require('mini.keymap').map_combo

    map_multistep('i', '<BS>', { 'minipairs_bs' })
    map_combo({ 'i', 'c', 'x', 's' }, 'jk', '<BS><BS><Esc>')
    map_combo('t', 'jk', '<BS><BS><C-\\><C-n>')

    vim.api.nvim_create_autocmd('TextYankPost', {
      pattern = '*',
      callback = function(_)
        vim.hl.on_yank { higroup = 'Visual' }
      end,
    })
  end,
}
