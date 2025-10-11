vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require 'morpheus'

local config = Morpheus.capabilities.configured

config.core = { whichkey = true }
config.ui = { theme = true, statusline = true }
config.lang = {
  lua = { treesitter = true },
  scala = { treesitter = true },
  go = { treesitter = true },
  ruby = { treesitter = true },
}

Morpheus.capabilities.install_all()
Morpheus.capabilities.configure_all()
