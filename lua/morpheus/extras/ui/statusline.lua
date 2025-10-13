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
    local catppuccin_theme = require('lualine.themes.catppuccin')

    local custom_bg = '#1e1e2e'

    -- Apply custom background to all sections
    for _, mode in pairs(catppuccin_theme) do
      if type(mode) == 'table' then
        if mode.b and type(mode.b) == 'table' then
          mode.b.bg = custom_bg
        end

        if mode.c and type(mode.c) == 'table' then
          mode.c.bg = custom_bg
        end

        if mode.x and type(mode.x) == 'table' then
          mode.x.bg = custom_bg
        end
      end
    end


    local line_x = {
      {
        'lsp_status',
        icon = '',
        symbols = {
          -- Standard unicode symbols to cycle through for LSP progress:
          spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
          done = '✓',
          separator = ' ',
        },
        ignore_lsp = {},
      },
      'copilot', 'codecompanion', 'encoding', 'fileformat', 'filetype' }
    return {
      options = {
        icons_enabled = true,
        component_separators = '',
        section_separators = '',
        --theme = 'catppuccin',
        theme = catppuccin_theme,
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
        lualine_c = { 'filename', 'aerial' },
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
      extensions = { 'oil', 'aerial', 'mason', 'toggleterm', 'lazy' },
    }
  end,
}
