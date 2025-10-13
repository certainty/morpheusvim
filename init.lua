vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require 'morpheus'

local config = Morpheus.capabilities

config.core = { whichkey = true }
config.ui = { theme = true, statusline = true, dashboard = true }
config.lang = {
  lua = { treesitter = true, lsp = true },
  scala = { treesitter = true, lsp = true },
  go = { treesitter = true, lsp = true, dap = true },
  ruby = { treesitter = true, lsp = true, ror = true },
}
config.ai = { copilot = true, codecompanion = { vectorcode = true, mcphub = false } }
config.tools = { git = true, terminal = true, onepassword = true }
config.writing = { markdown = { preview = true, images = true, lsp = true }, obsidian = true }

Morpheus.setup()
