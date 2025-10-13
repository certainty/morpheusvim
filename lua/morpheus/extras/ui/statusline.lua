return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  enabled = Morpheus.is_enabled { 'ui', 'statusline' },
  dependencies = {
    {
      'franco-ruggeri/codecompanion-lualine.nvim',
      enabled = Morpheus.is_enabled { 'ai', 'codecompanion' },
    },
    {
      { 'AndreM222/copilot-lualine', enabled = Morpheus.is_enabled { 'ai', 'copilot' } },
    },
  },
  opts = function()
    local line_x = { 'copilot', 'codecompanion', 'encoding', 'fileformat', 'filetype' }
    return {
      options = {
        icons_enabled = true,
        component_separators = '',
        section_separators = '',
        theme = 'catppuccin',
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'filename' },
        lualine_x = line_x,
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
