local utils = require 'morpheus.utils'

local M = {}

function M.install(_) end

function M.configure(_)
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
  vim.diagnostic.config(vim.g.diagnostic_config)
end

return M
