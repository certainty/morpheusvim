vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.have_nerd_font = true
vim.opt.number = true
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

-- TODO: make folds work
-- vim.o.foldmethod = 'syntax'
-- vim.o.foldenable = true
-- vim.o.foldlevelstart = 1
-- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

-- make the UI less cluttered
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  float = {
    border = 'rounded',
  },
}

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

-- [[ Configure and install plugins ]]
--
require('lazy').setup({
  require 'morpheus.base.whichkey',
  require 'morpheus.base.ui',
  require 'morpheus.base.display-elements',
  require 'morpheus.base.editing',
  require 'morpheus.base.completion',
  require 'morpheus.base.telescope',
  require 'morpheus.base.vc',
  require 'morpheus.base.files',
  require 'morpheus.base.dashboard',

  require 'morpheus.code.essentials',
  require 'morpheus.code.treesitter',
  require 'morpheus.code.lsp',
  require 'morpheus.code.debug',
  require 'morpheus.code.format',
  require 'morpheus.code.lint',

  require 'morpheus.code.scala',
  require 'morpheus.ai.copilot',

  -- one of these adds notable lag for some reason during typing
  -- require 'morpheus.ai.copilotchat',
  require 'morpheus.ai.avante',

  -- require 'morpheus.ai.chatgpt',
  require 'morpheus.tools.terminal',
  require 'morpheus.writing.markdown',
  require 'morpheus.writing.obsidian',
}, {
  ui = {
    icons = {},
  },
})

require 'morpheus.base.keys'

-- global keys
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
