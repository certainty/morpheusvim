local utils = require 'morpheus.utils'

local M = {}

function M.install(ctx)
  if not utils.is_enabled(ctx, { 'ai', 'copilot' }) then
    return
  end

  utils.plugin_install 'zbirenbaum/copilot.lua'
end

function M.configure(ctx)
  if not utils.is_enabled(ctx, { 'ai', 'copilot' }) then
    return
  end

  require('copilot').setup {
    suggestion = { enabled = false },
    panel = { enabled = false },
  }

  vim.keymap.set('n', '<leader>acc', '<cmd>Copilot enable<cr>', { desc = 'Enable Copilot' })
end

return M
