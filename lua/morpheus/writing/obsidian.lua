return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  config = function(_, opts)
    require('obsidian').setup(opts)
  end,

  init = function()
    vim.keymap.set('n', '<leader>n/', '<cmd>ObsidianQuickSwitch<CR>', { noremap = true, silent = true, desc = 'Quick Switch' })
    vim.keymap.set('n', '<leader>nn', '<cmd>ObsidianNew<CR>', { noremap = true, silent = true, desc = 'Open Notes' })
  end,

  opts = {
    ui = {
      enable = false,
      checkboxes = {
        ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
        ['!'] = { char = '', hl_group = 'ObsidianImportant' },
        [' '] = { char = '☐', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '✔', hl_group = 'ObsidianDone' },
      },
      bullets = { char = '•', hl_group = 'ObsidianBullet' },
    },
    picker = {
      name = 'telescope.nvim',
    },
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    workspaces = {
      {
        name = 'shared',
        path = '~/SharedNotes',
      },
    },
  },
}
