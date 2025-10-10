vim.pack.add({ 'https://github.com/mason-org/mason.nvim.git' })
require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})
