-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local M = {}
local utils = require 'morpheus.utils'

M.capabilities = {
  core = { whichkey = false },
  ui = { theme = false, statusline = false },
  lang = {
    go = { treesitter = false, lsp = false, dap = false, test = false },
    ruby = { treesitter = false, lsp = false, dap = false, test = false },
    scala = { treesitter = false, lsp = false, dap = false, test = false },
    terraform = { treesitter = false, lsp = false, test = false },
    json = { treesitter = false, lsp = false },
    yaml = { treesitter = false, lsp = false },
  },
  writing = { markdown = true },
  ai = { codecompanion = { vectorcode = false, mcphub = false }, copilot = true },
  tools = { git = true, terminal = true },
}

function M.is_enabled(path)
  local value = utils.dig(M.capabilities, path)
  return value ~= nil and value ~= false
end

function M.setup()
  require('lazy').setup({
    { import = 'morpheus.core' },
    { import = 'morpheus.extras.ui' },
    { import = 'morpheus.extras.ai' },
  }, {
    ui = { border = 'rounded' },
  })
end

_G.Morpheus = M
