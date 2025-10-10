vim.pack.add({ 'https://github.com/allaman/emoji.nvim.git' })

require('emoji').setup()

vim.pack.add({ 'https://github.com/nvim-mini/mini.bracketed.git' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.comment.git' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.pairs.git' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.ai.git' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.surround.git' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.trailspace.git' })


require('mini.bracketed').setup()
require('mini.comment').setup()
require('mini.pairs').setup()
require('mini.ai').setup()
require('mini.surround').setup()

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Init trailspace',
  group = vim.api.nvim_create_augroup('mini', { clear = true }),
  callback = function()
    require('mini.trailspace').setup({ only_in_normal_buffers = true })
  end,
})
