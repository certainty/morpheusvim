vim.keymap.set('n', '<leader><leader>', function()
  require('mini.pick').builtin.files()
end, { desc = 'File' })

vim.keymap.set('n', '<leader>gf', function()
  require('mini.pick').builtin.files({ tool = 'git' })
end, { desc = 'Files (Git)' })



vim.keymap.set('n', '<leader>go', function()
  require('mini.extra').pickers.oldfiles()
end, { desc = 'Recent' })
