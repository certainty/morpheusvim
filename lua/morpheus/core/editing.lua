vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

require('vim._extui').enable {}

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.winborder = 'rounded'

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

local mini = {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
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
    require('mini.extra').setup()

    vim.keymap.set('n', '<leader>gb', MiniPick.builtin.buffers, { desc = 'Buffers' })
    vim.keymap.set('n', '<leader>hh', MiniPick.builtin.help, { desc = 'Help' })
    vim.keymap.set('n', '<leader>hk', MiniExtra.pickers.keymaps, { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>ss', MiniPick.builtin.grep_live, { desc = 'Search' })
    vim.keymap.set('n', '<leader>sS', MiniPick.builtin.grep, { desc = 'Search*' })
    vim.keymap.set('n', '<leader>gr', MiniPick.builtin.resume, { desc = 'Resume' })
    vim.keymap.set('n', '<leader><leader>', function()
      MiniPick.builtin.files { tool = 'git' }
    end, { desc = 'File (Git)' })

    vim.keymap.set('n', '<leader>gf', MiniPick.builtin.files, { desc = 'Files' })
    vim.keymap.set('n', '<leader>go', MiniExtra.pickers.oldfiles, { desc = 'Recent' })
  end,
}

local oil = {
  'stevearc/oil.nvim',
  keys = {
    { '<leader>e', '<cmd>Oil<cr>', desc = 'Files' },
  },
  opts = {
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
  },
}

return {
  mini,
  oil,
}
