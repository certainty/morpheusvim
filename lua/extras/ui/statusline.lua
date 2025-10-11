local utils = require 'morpheus.utils'

local M = {}

function M.install(ctx)
  if not ctx.statusline then
    return
  end

  utils.plugin_install 'nvim-lualine/lualine.nvim'
end

function M.configure(ctx)
  if not ctx.statusline then
    return
  end

  require('lualine').setup {
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
      lualine_x = { 'codecompanion', 'encoding', 'fileformat', 'filetype' },
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
end

return M
