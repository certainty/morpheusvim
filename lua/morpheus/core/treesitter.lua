local utils = require 'morpheus.utils'

local function install_parsers(parsers)
  local treesitter = require 'nvim-treesitter'
  treesitter.install(parsers):wait(300000)
  utils.log('installing parsers: ' .. vim.inspect(parsers))
end

local function enable_treesitter()
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  vim.treesitter.start()
end

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local installed_parsers = {
      'lua',
      'vim',
      'vimdoc',
      'diff',
    }

    if Morpheus.is_enabled { 'lang', 'go', 'treesitter' } then
      table.insert(installed_parsers, 'go')
      table.insert(installed_parsers, 'gomod')
      table.insert(installed_parsers, 'gosum')

      utils.ftcmd('go', 'go', enable_treesitter)
    end

    if Morpheus.is_enabled { 'lang', 'scala', 'treesitter' } then
      table.insert(installed_parsers, 'scala')
      utils.ftcmd('scala', 'scala', function(bctx)
        enable_treesitter()
        bctx.map('n', '<localleader>mi', '<cmd>MetalsInstall<cr>', {})
        bctx.map('n', '<localleader>mu', '<cmd>MetalsUpdate<cr>', {})
      end)
    end

    if Morpheus.is_enabled { 'lang', 'ruby', 'treesitter' } then
      table.insert(installed_parsers, 'ruby')

      utils.ftcmd('ruby', 'ruby', enable_treesitter)
    end

    if Morpheus.is_enabled { 'lang', 'lua', 'treesitter' } then
      table.insert(installed_parsers, 'lua')
      utils.ftcmd('lua', 'lua', enable_treesitter)
    end

    if Morpheus.is_enabled { 'lang', 'yaml', 'treesitter' } then
      table.insert(installed_parsers, 'yaml')
      utils.ftcmd('yaml', 'yaml', enable_treesitter)
    end

    if Morpheus.is_enabled { 'lang', 'json', 'treesitter' } then
      table.insert(installed_parsers, 'json')
      utils.ftcmd('json', 'json', enable_treesitter)
    end

    vim.keymap.set('n', '<leader>Vt', function()
      install_parsers(installed_parsers)
    end, { desc = 'Install all TreeSitter parsers' })

    vim.keymap.set('n', '<leader>gt', function()
      require('mini.extra').pickers.treesitter()
    end, { desc = 'Treesitter' })
  end,
}
