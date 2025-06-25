return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    preset = 'helix',
    delay = 0.3,
    triggers = {
      { '<leader>', mode = { 'n', 'v' } },
      { '<localleader>', mode = { 'n', 'v' } },
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
    spec = {
      { '<leader>a', group = 'AI', mode = { 'n', 'v' } },
      { '<leader>c', group = 'Code', mode = { 'n', 'x' } },
      { '<leader>t', group = 'Test' },
      { '<leader>n', group = 'Notes' },
      { '<leader>d', group = 'Debug' },
      { '<leader>g', group = 'Goto' },
      { '<leader>s', group = 'Search' },
      { '<leader>r', group = 'Run' },
      { '<leader>m', group = 'Format' },
      { '<leader>u', group = 'Ux' },
      { '<leader>ut', group = 'Toggle' },
      { '<leader>v', group = 'Vcs', mode = { 'n', 'v' } },
      { '<leader>w', group = 'Workspace' },
      { '<leader>1', group = '1Password' },
      { '<leader>!', group = 'Diagnostics' },
    },
  },
}
