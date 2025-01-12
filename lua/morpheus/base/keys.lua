return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    delay = 0.3,
    triggers = { '<leader>', '<localleader>' },
    win = {
      border = 'rounded',
    },
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {},
    },

    spec = {
      { '<leader>c', group = 'Code', mode = { 'n', 'x' } },
      { '<leader>t', group = 'Test' },
      { '<leader>D', group = 'Debug' },
      { '<leader>d', group = 'Document' },
      { '<leader>g', group = 'Goto' },
      { '<leader>s', group = 'Search' },
      { '<leader>f', group = 'Format' },
      { '<leader>u', group = 'Ux' },
      { '<leader>ut', group = 'Toggle' },
      { '<leader>v', group = 'Vcs', mode = { 'n', 'v' } },
      { '<leader>w', group = 'Workspace' },
    },
  },
}
