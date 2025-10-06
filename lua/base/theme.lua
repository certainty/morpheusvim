return {
  {
    'cormacrelf/dark-notify',
    init = function()
      require('dark_notify').run()
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'auto',
      background = { -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      color_overrides = {
        mocha = {
          base = '#000000',
          mantle = '#000000',
          crust = '#000000',
        },
        latte = {
          base = '#eeeeee',
        },
      },
      default_integrations = true,
      integrations = {
        cmp = true,
        mason = true,
        aerial = true,
        neogit = true,
        neotest = true,
        dap = true,
        dap_ui = true,
        diffview = true,
        gitsigns = true,
        neotree = true,
        telescope = true,
        which_key = true,
        treesitter = true,
        mini = {
          enabled = true,
          indentscope_color = 'lavendar',
        },
      },
    },
    keys = {
      { '<leader>ul', '<cmd>colorscheme catppuccin-latte<CR>', desc = 'ColorScheme Light' },
      { '<leader>ud', '<cmd>colorscheme catppuccin-mocha<CR>', desc = 'ColorScheme Dark' },
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
