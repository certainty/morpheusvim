require 'base.settings'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('morpheus-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'base.whichkey',
  require 'base.theme',
  require 'base.display',
  require 'base.editing',
  require 'base.completion',
  require 'base.telescope',
  require 'base.vc',
  require 'base.files',
  require 'base.dashboard',

  require 'code.essentials',
  require 'code.treesitter',
  require 'code.tests',
  require 'code.debug',
  require 'code.lsp',
  require 'code.format',
  require 'code.lint',
  require 'code.scala',
  require 'code.clojure',
  require 'code.go',
  require 'code.ruby',

  require 'ai.vectorcode',
  require 'ai.copilot',
  require 'ai.codecompanion',
  require 'ai.mcphub',

  require 'tools.terminal',
  require 'tools.harpoon',

  require 'writing.markdown',
  require 'writing.obsidian',
}, {
  ui = {
    icons = {},
  },
})

vim.filetype.add {
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    ['.*/templates/.*%.tpl'] = 'helm',
    ['.*/templates/.*%.ya?ml'] = 'helm',
    ['helmfile.*%.ya?ml'] = 'helm',
  },
}

require 'base.keys'

-- vim: ts=2 sts=2 sw=2 et
