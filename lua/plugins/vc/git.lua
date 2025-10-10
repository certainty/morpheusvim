vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim.git' })
vim.pack.add({ 'https://github.com/sindrets/diffview.nvim.git' })
vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim.git' })
vim.pack.add({ 'https://github.com/NeogitOrg/neogit.git' })

require('neogit').setup {
  integrations = {
    diffview = true
  },
  disable_commit_confirmation = true,
}

require('gitsigns').setup {}

vim.keymap.set('n', '<localleader>vB', function() require('gitsigns').blame() end, { desc = 'blame', buffer = 0 })
vim.keymap.set('n', '<localleader>,vtb', function() require('gitsigns').toggle_current_line_blame() end,
  { desc = 'toggle blame', buffer = 0 })
vim.keymap.set('n', '<localleader>,vb', function() require('gitsigns').blame_line() end,
  { desc = 'blame line', buffer = 0 })
vim.keymap.set('n', '<localleader>vD', function() require('gitsigns').diffthis '@' end,
  { desc = 'diff against last commit', buffer = 0 })

vim.keymap.set('n', '<leader>vv', function()
  require('neogit').open()
end, { desc = 'Neogit' })


vim.keymap.set('n', '<leader>gvb', function() require('mini.extra').pickers.git_branches() end, { desc = 'Branches' })
vim.keymap.set('n', '<leader>gvc', function() require('mini.extra').pickers.git_commits() end, { desc = 'Commits' })
vim.keymap.set('n', '<leader>gvh', function() require('mini.extra').pickers.git_hunks() end, { desc = 'Hunks' })
