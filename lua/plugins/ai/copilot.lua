vim.pack.add({ 'https://github.com/zbirenbaum/copilot.lua.git' })
vim.pack.add({ 'https://github.com/copilotlsp-nvim/copilot-lsp.git' })

require('copilot').setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
