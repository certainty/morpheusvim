vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.o.number = true
vim.o.signcolumn = 'yes'

require 'morpheus'
local config = Morpheus.capabilities

config.core = { whichkey = true }
config.ui = { theme = true, statusline = true, dashboard = true }
config.lang = {
  lua = { treesitter = true, lsp = true, dap = true },
  scala = { treesitter = true, lsp = true, test = true, dap = true },
  go = { treesitter = true, lsp = true, dap = true, test = true },
  ruby = { treesitter = true, lsp = true, ror = true, test = true, dap = true },
}
config.ai = { copilot = true, codecompanion = { vectorcode = true, mcphub = false } }
config.tools = { git = true, terminal = true, onepassword = true, colorizer = true }
config.writing = { markdown = { preview = true, images = true, lsp = true }, obsidian = true }

Morpheus.setup()
