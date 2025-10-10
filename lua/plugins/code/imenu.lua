vim.pack.add({ 'https://github.com/stevearc/aerial.nvim.git' })


require('aerial').setup({
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
})

vim.keymap.set('n', '<leader>i', function() require('aerial').toggle() end, { desc = 'Code Symbols' })
