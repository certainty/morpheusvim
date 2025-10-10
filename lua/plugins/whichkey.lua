vim.pack.add({ 'https://github.com/folke/which-key.nvim.git' })

require('which-key').setup({
  preset = 'helix',
  delay = 0.3,
  triggers = {
    { '<leader>',       mode = { 'n', 'v' } },
    { '<localleader>',  mode = { 'n', 'v' } },
    { '<localleader>,', mode = { 'n', 'v' } },
    { 'g',              mode = { 'n', 'v' } },
    { 's',              mode = { 'n' } },
    { '[',              mode = { 'n', 'v' } },
    { ']',              mode = { 'n', 'v' } },
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
})
