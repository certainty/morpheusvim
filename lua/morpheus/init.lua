local M = {}

M.vim_nightly = vim.version().api_prerelease

M.settings = require 'morpheus.settings'

-- some utils
function M.log(msg)
  vim.notify('[Morpheus] ' .. msg, vim.log.levels.INFO)
end

function M.warn(msg)
  vim.notify('[Morpheus] ' .. msg, vim.log.levels.WARN)
end

function M.error(msg)
  vim.notify('[Morpheus] ' .. msg, vim.log.levels.ERROR)
end

_G.Morpheus = M

require 'morpheus.lazy'

return _G.Morpheus
