-- lua/morpheus/init.lua
--
-- Global API for Morpheus

local M = {}

M.utils = require 'morpheus.utils'
M.capabilities = require 'morpheus.capabilities'
M.loader = require 'morpheus.loader'

-- Global object for convenience
_G.Morpheus = M

function _G.Morpheus.status()
  _G.Morpheus.loader.status()
end

function _G.Morpheus.status_buffer()
  _G.Morpheus.loader.status_buffer()
end

vim.api.nvim_create_user_command('MorpheusStatus', function()
  Morpheus.status()
end, { desc = 'Show MorpheusNvim system status' })

vim.api.nvim_create_user_command('MorpheusInspect', function()
  Morpheus.status_buffer()
end, { desc = 'Show MorpheusNvim system status' })

return M
