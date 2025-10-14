vim.lsp.enable 'solargraph'
vim.lsp.enable 'ruby-lsp'

return {
  'weizheheng/ror.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<localleader>:', desc = 'List Rails Commands', buffer = true },
    { '<localleader>r', desc = 'Run Rails Command', buffer = true },
  },
}
