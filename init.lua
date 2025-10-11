vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require 'morpheus'

local config = Morpheus.capabilities.configured

config.core = { whichkey = true }
config.ui = { theme = true, statusline = true }
config.lang = {
  lua = { treesitter = true, lsp = true },
  scala = { treesitter = true, lsp = true },
  go = { treesitter = true, lsp = true },
  ruby = { treesitter = true, lsp = true },
}

Morpheus.capabilities.install_all()
Morpheus.capabilities.configure_all()
