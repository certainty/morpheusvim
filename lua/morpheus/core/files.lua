return {
  {
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
  },
  {
    'nvim-mini/mini.sessions',
    dependencies = {
      'nvim-mini/mini.visits',
    },
    lazy = false,
    config = function()
      require('mini.sessions').setup()
      require('mini.visits').setup()
    end,
  },
}
