return {
  {
    'cormacrelf/dark-notify',
    init = function()
      require('dark_notify').run()
    end,
  },
  {
    'miikanissi/modus-themes.nvim',
    priority = 1000,
    config = function()
      require('modus-themes').setup {
        -- Theme comes in two styles `modus_operandi` and `modus_vivendi`
        -- `auto` will automatically set style based on background set with vim.o.background
        style = 'auto',
        variant = 'default', -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
        transparent = false, -- Transparent background (as supported by the terminal)
        dim_inactive = false, -- "non-current" windows are dimmed
        hide_inactive_statusline = false, -- Hide statuslines on inactive windows. Works with the standard **StatusLine**, **LuaLine** and **mini.statusline**
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },

        --- You can override specific color groups to use other groups or a hex color
        --- Function will be called with a ColorScheme table
        --- Refer to `extras/lua/modus_operandi.lua` or `extras/lua/modus_vivendi.lua` for the ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- Function will be called with a Highlights and ColorScheme table
        --- Refer to `extras/lua/modus_operandi.lua` or `extras/lua/modus_vivendi.lua` for the Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
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
