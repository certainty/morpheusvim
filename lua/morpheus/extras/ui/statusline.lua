return {
  'nvim-lualine/lualine.nvim',
  enabled = Morpheus.is_enabled { 'ui', 'statusline' },
  dependencies = {
    {
      'franco-ruggeri/codecompanion-lualine.nvim',
      enabled = Morpheus.is_enabled { 'ai', 'codecompanion' },
    },
  },
  opts = function()
    local line_x = {}

    if Morpheus.is_enabled { 'ai', 'codecompanion' } then
      lualine_x = { 'codecompanion', 'encoding', 'fileformat', 'filetype' }
    else
      lualine_x = { 'encoding', 'fileformat', 'filetype' }
    end

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
        lualine_b = { 'branch' },
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
