return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
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
      }
    end,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
