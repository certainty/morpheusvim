local utils = require 'morpheus.utils'

local M = {}

function M.install()
  utils.plugin_install 'nvim-mini/mini.nvim'
end

function M.configure()
  vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
  end)

  require('mini.basics').setup {
    options = {
      basic = true,
      extra_ui = false,
      win_borders = 'auto',
    },

    mappings = {
      basic = true,
      option_toggle_prefix = [[\]],
      windows = false,
      move_with_alt = false,
    },

    autocommands = {
      basic = true,
      relnum_in_visual_mode = true,
    },
    silent = false,
  }

  require('mini.bracketed').setup()
  require('mini.comment').setup()
  require('mini.pairs').setup()
  require('mini.ai').setup()
  require('mini.align').setup()
  require('mini.surround').setup()

  require('mini.sessions').setup()
  require('mini.visits').setup()

  require('mini.bufremove').setup()
  require('mini.icons').setup()
  require('mini.trailspace').setup()
end

return M
