vim.pack.add({ 'https://github.com/onsails/lspkind.nvim.git' })

require('lspkind').init({
  enabled = true,
  mode = 'symbol_text',
  preset = 'codicons',
  symbol_map = {
    Copilot = '',
  },
  menu = {},
})
