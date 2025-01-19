return {
  {
    'echasnovski/mini.sessions',
    version = false,
    config = function()
      require('mini.sessions').setup {}
    end,
  },
  {
    'echasnovski/mini.starter',
    version = false,
    config = function()
      local starter = require 'mini.starter'

      starter.setup {
        items = {
          starter.sections.builtin_actions(),
          starter.sections.recent_files(10, false),
          starter.sections.recent_files(10, true),
          -- Use this if you set up 'mini.sessions'
          starter.sections.sessions(5, true),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.indexing('all', { 'Builtin actions' }),
          starter.gen_hook.padding(3, 2),
        },
      }
    end,
  },
  -- {
  --   'nvimdev/dashboard-nvim',
  --   event = 'VimEnter',
  --   config = function()
  --     require('dashboard').setup {
  --       config = {
  --         week_header = {
  --           enable = true,
  --         },
  --       },
  --     }
  --   end,
  --   dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  -- },
}
