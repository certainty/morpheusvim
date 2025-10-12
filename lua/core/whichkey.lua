local M = {}
local utils = require 'morpheus.utils'

function M.install(ctx)
  if not utils.is_enabled(ctx, { 'core', 'whichkey' }) then
    return
  end

  utils.plugin_install 'folke/which-key.nvim'
end

function M.configure(ctx)
  if not utils.is_enabled(ctx, { 'core', 'whichkey' }) then
    return
  end

  local whichkeySpec = {
    { '<leader>!', group = 'Diagnostics', mode = { 'n', 'v' } },
    { '<leader>c', group = 'Code', mode = { 'n', 'v' } },
    { '<leader>h', group = 'Help', mode = { 'n', 'v' } },
    { '<leader>g', group = 'Goto', mode = { 'n', 'v' } },
    { '<leader>s', group = 'Search', mode = { 'n', 'v' } },
    { '<leader>u', group = 'Ux', mode = { 'n' } },
    { '<leader>V', group = 'Morpheus', mode = { 'n' } },
  }

  if utils.is_enabled(ctx, { 'ai' }) then
    table.insert(whichkeySpec, { '<leader>a', group = 'AI', mode = { 'n', 'v' } })
  end

  if utils.is_enabled(ctx, { 'tools', 'git' }) then
    table.insert(whichkeySpec, { '<leader>v', group = 'Git', mode = { 'n', 'v' } })
  end

  if utils.is_enabled(ctx, { 'tools', 'terminal' }) then
    table.insert(whichkeySpec, { '<leader>\\', group = 'Term', mode = { 'n', 'v' } })
  end

  if utils.is_enabled(ctx, { 'writing' }) then
    table.insert(whichkeySpec, { '<leader>n', group = 'Notes', mode = { 'n', 'v' } })
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
    spec = whichkeySpec,
  }
end

return M
