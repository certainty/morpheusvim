local utils = require 'morpheus.utils'

local M = {}

function M.install(ctx)
  if not utils.is_enabled(ctx, { 'tools', 'git' }) then
    return
  end

  utils.plugin_install 'nvim-lua/plenary.nvim'
  utils.plugin_install 'NeogitOrg/neogit'
  utils.plugin_install 'sindrets/diffview.nvim'
  utils.plugin_install 'lewis6991/gitsigns.nvim'
end

function M.configure(ctx)
  if not utils.is_enabled(ctx, { 'tools', 'git' }) then
    return
  end

  require('neogit').setup {
    integrations = {
      diffview = true,
    },
  }
  require('diffview').setup {}

  vim.keymap.set('n', '<leader>vv', '<cmd>Neogit<CR>', { desc = 'Neogit' })
  vim.keymap.set('n', '<localleader>,vb', require('gitsigns').blame_line, { desc = 'Blame Line', buffer = 0 })
  vim.keymap.set('n', '<leader>vtb', require('gitsigns').toggle_current_line_blame, { desc = 'Toggle Blame Line', buffer = 0 })
end

return M
