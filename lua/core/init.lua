local utils = require 'morpheus.utils'

local M = {}

function M.install()
  utils.plugin_install 'nvim-mini/mini.nvim'
end

function M.configure()
  require('mini.ai').setup()
  require('mini.pairs').setup()
end

return M
