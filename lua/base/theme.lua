return {
  {
    'cormacrelf/dark-notify',
    init = function()
      require('dark_notify').run()
    end,
  },
  {
    'miikanissi/modus-themes.nvim',
    init = function()
      -- vim.cmd.colorscheme 'modus_vivendi'
      -- vim.cmd.hi 'Comment gui=none'
    end,
    config = function()
      require('modus-themes').setup {
        style = 'modus_vivendi',
        variant = 'default',
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },

        ---@param colors ColorScheme
        on_colors = function(colors) end,

        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      }
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      -- vim.cmd.colorscheme 'tokyonight-night'
    end,
    config = function()
      require('tokyonight').setup {
        style = 'night',
        on_colors = function(colors)
          colors.bg = '#000000'
        end,
      }
    end,
  },
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
      }
    end,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
      vim.cmd.hi 'Comment gui=none'
      -- set to light
      local ux_map = require('base.keymap').group('n', 'ux')
      ux_map('dl', '<cmd>colorscheme catppuccin-latte<CR>', 'ColorScheme Light')
      ux_map('dd', '<cmd>colorscheme catppuccin-mocha<CR>', 'ColorScheme Dark')
    end,
  },
}
