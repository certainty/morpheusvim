local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
local diagnostic_signs = {}
for type, icon in pairs(signs) do
  diagnostic_signs[vim.diagnostic.severity[type]] = icon
end
vim.g.diagnostic_config = {
  signs = { text = diagnostic_signs },
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  float = {
    border = 'rounded',
  },
}
vim.diagnostic.config(vim.g.diagnostic_config)
vim.keymap.set('n', '<leader>!!', function()
  require('mini.extra').pickers.diagnostic()
end, { desc = 'Diagnostics' })

return {
  'stevearc/aerial.nvim',
  enable = Morpheus.is_enabled { 'tools', 'imenu' },
  opts = {
    filter_kind = { -- Symbols that will appear on the tree
      'Class',
      'Constructor',
      'Enum',
      'Function',
      'Interface',
      'Module',
      'Method',
      'Struct',
    },
    highlight_mode = 'last',
    highlight_on_jump = 1000,
    highlight_on_hover = true,
    highlight_closest = true,
    open_automatic = false,
    autojump = true,
    link_folds_to_tree = false,
    link_tree_to_folds = false,
    attach_mode = 'global',
    backends = { 'treesitter', 'lsp', 'markdown', 'man', 'asciidoc' },
    layout = {
      min_width = 28,
      default_direction = 'left',
      placement = 'edge',
    },
    show_guides = true,
    guides = {
      mid_item = '├ ',
      last_item = '└ ',
      nested_top = '│ ',
      whitespace = '  ',
    },
  },
  keys = {
    { '<leader>i', '<cmd>AerialToggle<CR>', desc = 'IMenu' },
  }
}
