local M = {}
local utils = require 'morpheus.utils'

function M.install(ctx)
  if not ctx.whichkey then
    return
  end

  utils.plugin_install 'folke/which-key.nvim'
end

function M.configure(ctx)
  if not ctx.whichkey then
    return
  end

  require('which-key').setup {
    preset = 'helix',
    delay = 0.3,
    triggers = {
      { '<leader>', mode = { 'n', 'v' } },
      { '<localleader>', mode = { 'n', 'v' } },
      { '<localleader>,', mode = { 'n', 'v' } },
      { 'g', mode = { 'n', 'v' } },
      { 's', mode = { 'n' } },
      { '[', mode = { 'n', 'v' } },
      { ']', mode = { 'n', 'v' } },
    },
    win = {
      border = 'rounded',
    },
    sort = { 'local', 'order', 'group', 'alphanum', 'mod' },
    icons = {
      separator = ' ',
      group = ' +',
      keys = {},
    },
  }
end

return M
