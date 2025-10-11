local utils = require 'morpheus.utils'

local M = {}

M.lsps = {}

function M.install(ctx)
  utils.plugin_install 'mason-org/mason.nvim'
  utils.plugin_install 'onsails/lspkind.nvim'
  utils.plugin_install 'j-hui/fidget.nvim'

  if utils.is_enabled(ctx, { 'scala', 'lsp' }) then
    utils.plugin_install 'scalameta/nvim-metals'
  end
end

function M.configure(ctx)
  if utils.is_enabled(ctx, { 'go', 'lsp' }) then
    table.insert(M.lsps, 'gopls')
  end

  if utils.is_enabled(ctx, { 'ruby', 'lsp' }) then
    table.insert(M.lsps, 'ruby-lsp')
    table.insert(M.lsps, 'solargraph')
  end

  if utils.is_enabled(ctx, { 'lua', 'lsp' }) then
    table.insert(M.lsps, 'lua_ls')
  end

  vim.lsp.enable(M.lsps)
  utils.log('configured lsps: ' .. vim.inspect(M.lsps))

  require('mason').setup {
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  }

  require('lspkind').init {
    enabled = true,
    mode = 'symbol_text',
    preset = 'codicons',
    symbol_map = {
      Copilot = '',
    },
    menu = {},
  }

  require('fidget').setup {}
end

return M
