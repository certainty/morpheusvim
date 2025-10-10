vim.keymap.set('n', '<leader><leader>', function()
  require('mini.pick').builtin.files({ tool = 'git' })
end, { desc = 'File (Git)' })

vim.keymap.set('n', '<leader>gf', function()
  require('mini.pick').builtin.files()
end, { desc = 'Files' })

vim.keymap.set('n', '<leader>go', function()
  require('mini.extra').pickers.oldfiles()
end, { desc = 'Recent' })
