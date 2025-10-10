vim.pack.add { 'https://github.com/nvimdev/dashboard-nvim.git' }
vim.pack.add { 'https://github.com/nvim-mini/mini.sessions.git' }

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    require('mini.sessions').setup()
    require('dashboard').setup {
      theme = 'hyper',
    }
  end,
})
