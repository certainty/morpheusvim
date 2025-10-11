local utils = require 'morpheus.utils'

local M = {}

function M.install()
  utils.plugin_install 'nvim-mini/mini.nvim'
  utils.plugin_install 'stevearc/oil.nvim'
  utils.plugin_install 'psjay/buffer-closer.nvim'
end

local ivy = function()
  local height = math.floor(0.3 * vim.o.lines)
  local width = vim.o.columns - 2
  return {
    anchor = 'NW',
    height = height,
    width = width,
    row = math.floor(vim.o.lines - height),
    col = math.floor(vim.o.columns - 2),
  }
end

function M.configure()
  vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
  end)

  require('buffer-closer').setup()

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
  require('mini.pick').setup {
    window = { config = ivy },
    options = {
      content_from_bottom = false,
      use_icons = true,
    },
  }

  vim.keymap.set('n', '<leader>gb', function()
    MiniPick.builtin.buffers()
  end, { desc = 'Buffers' })

  vim.keymap.set('n', '<leader>hh', function()
    MiniPick.builtin.help()
  end, { desc = 'Help' })

  vim.keymap.set('n', '<leader>hc', function() end, { desc = 'Commands' })
  vim.keymap.set('n', '<leader>hk', function()
    MiniExtra.pickers.keymaps()
  end, { desc = 'Keymaps' })

  vim.keymap.set('n', '<leader>ss', function()
    MiniPick.builtin.grep_live()
  end, { desc = 'Search' })

  vim.keymap.set('n', '<leader>sS', function()
    MiniPick.builtin.grep()
  end, { desc = 'Search*' })

  vim.keymap.set('n', '<leader>gr', function()
    MiniPick.builtin.resume()
  end, { desc = 'Resume' })

  vim.keymap.set('n', '<leader><leader>', function()
    MiniPick.builtin.files { tool = 'git' }
  end, { desc = 'File (Git)' })

  vim.keymap.set('n', '<leader>gf', function()
    MiniPick.builtin.files()
  end, { desc = 'Files' })

  vim.keymap.set('n', '<leader>go', function()
    MiniPick.pickers.oldfiles()
  end, { desc = 'Recent' })

  require('oil').setup {
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        local m = name:match '^%.'
        return m ~= nil
      end,
    },
    is_always_hidden = function(name, bufnr)
      return false
    end,
    default_file_explorer = true,
    keymaps = {
      ['^'] = { 'actions.parent', mode = 'n' },
    },
  }

  vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'Dired' })
end

return M
