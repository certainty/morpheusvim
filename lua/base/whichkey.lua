return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
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
    mappings = vim.g.have_nerd_font,
    sort = { 'local', 'order', 'group', 'alphanum', 'mod' },
    icons = {
      separator = ' ',
      group = ' +',
      keys = vim.g.have_nerd_font and {},
    },
    spec = require('base.keymap').whichkey_spec(),
  },
}
