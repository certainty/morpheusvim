vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git', version = 'main' } })

vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Update TreeSitter',
  group = vim.api.nvim_create_augroup('treesitter', { clear = true }),
  callback = function()
    vim.cmd('TSUpdate')
  end,
})

local treesitter = require('nvim-treesitter')

function InstallAllTS()
  treesitter.install({
    'lua',
    'vim',
    'vimdoc',
    'query',
    'markdown',
    'markdown_inline',
    'json',
    'yaml',
    'bash',
    'html',
    'css',
    'javascript',
    'typescript',
    'ruby',
    'comment',
    'go',
    'gomod',
    'gosum',
    'scala',
    'diff',
    'c',
    'bash',
    'graphql',
    'sql'
  }):wait(300000)
end

vim.keymap.set('n', '<leader>Vt', InstallAllTS, { desc = 'Install all TreeSitter parsers' })
vim.keymap.set('n', '<leader>gt', function() require('mini.extra').pickers.treesitter() end, { desc = 'Treesitter' })
