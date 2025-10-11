local utils = require 'morpheus.utils'

local M = {}

M.installed_parsers = {
  'lua',
  'vim',
  'vimdoc',
  'diff',
}

function M.install(_)
  utils.plugin_install('nvim-treesitter/nvim-treesitter', 'main')
end

function M.install_parsers()
  local treesitter = require 'nvim-treesitter'
  utils.log('installing parsers: ' .. vim.inspect(M.installed_parsers))
  treesitter.install(M.installed_parsers):wait(30000)
end

local function enable_treesitter(ctx)
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  vim.treesitter.start()
end

function M.configure(ctx)
  if utils.is_enabled(ctx, { 'go', 'treesitter' }) then
    table.insert(M.installed_parsers, 'go')
    table.insert(M.installed_parsers, 'gomod')
    table.insert(M.installed_parsers, 'gosum')

    utils.ftcmd('go', 'go', enable_treesitter)
  end

  if utils.is_enabled(ctx, { 'scala', 'treesitter' }) then
    table.insert(M.installed_parsers, 'scala')
    utils.ftcmd('scala', 'scala', enable_treesitter)

    ctx.map('n', '<localleader>mi', '<cmd>MetalsInstall<cr>', {})
    ctx.map('n', '<localleader>mu', '<cmd>MetalsUpdate<cr>', {})
  end

  if utils.is_enabled(ctx, { 'ruby', 'treesitter' }) then
    table.insert(M.installed_parsers, 'ruby')

    utils.ftcmd('ruby', 'ruby', enable_treesitter)
  end

  if utils.is_enabled(ctx, { 'lua', 'treesitter' }) then
    table.insert(M.installed_parsers, 'lua')
    utils.ftcmd('lua', 'lua', enable_treesitter)
  end

  vim.keymap.set('n', '<leader>Vt', function()
    M.install_parsers()
  end, { desc = 'Install all TreeSitter parsers' })

  vim.keymap.set('n', '<leader>gt', function()
    require('mini.extra').pickers.treesitter()
  end, { desc = 'Treesitter' })
end

return M
