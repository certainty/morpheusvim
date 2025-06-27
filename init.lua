vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = false -- this is annoying
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'
vim.opt.cursorline = false
vim.opt.scrolloff = 10

-- vim.o.foldmethod = 'syntax'
-- vim.o.foldenable = true
-- vim.o.foldlevelstart = 1
-- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

-- global object that we use to configure diagnostics consistently.
-- some plubins insist on setting it themselves and we overwrite with what we have here

if vim.g.have_nerd_font then
  local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
  local diagnostic_signs = {}
  for type, icon in pairs(signs) do
    diagnostic_signs[vim.diagnostic.severity[type]] = icon
  end
  vim.g.diagnostic_config = {
    signs = { text = diagnostic_signs },
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    float = {
      border = 'rounded',
    },
  }
else
  vim.g.diagnostic_config = {
    signs = true,
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    float = {
      border = 'rounded',
    },
  }
  vim.diagnostic.config {
    signs = true,
    virtual_text = false,
  }
end
vim.diagnostic.config(vim.g.diagnostic_config)

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
  require 'base.display-elements',
  require 'base.editing',
  require 'base.completion',
  require 'base.telescope',
  require 'base.vc',
  require 'base.files',
  require 'base.dashboard',

  require 'code.essentials',
  require 'code.treesitter',
  require 'code.debug',
  require 'code.lsp',
  require 'code.format',
  require 'code.lint',
  require 'code.scala',
  require 'code.clojure',
  require 'code.go',
  require 'code.ruby',

  require 'ai.copilot',
  require 'ai.codecompanion',

  require 'tools.terminal',
  require 'tools.harpoon',

  require 'writing.markdown',
  require 'writing.obsidian',
}, {
  ui = {
    icons = {},
  },
})

require 'base.keys'

-- vim: ts=2 sts=2 sw=2 et
