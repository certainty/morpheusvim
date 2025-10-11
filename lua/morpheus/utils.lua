-- lua/morpheus/utils.lua
local M = {}

function M.log(msg)
  vim.notify('[Morpheus] ' .. msg, vim.log.levels.INFO)
end
function M.warn(msg)
  vim.notify('[Morpheus] ' .. msg, vim.log.levels.WARN)
end
function M.error(msg)
  vim.notify('[Morpheus] ' .. msg, vim.log.levels.ERROR)
end

function M.guard(cap, sub)
  if not require('morpheus.capabilities').is_enabled(cap, sub) then
    return true
  end
end

local function groupName(group)
  return 'Morpheus' .. group
end

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.autocmd(group, event, pattern, callback)
  local grp = vim.api.nvim_create_augroup(groupName(group), { clear = true })

  vim.api.nvim_create_autocmd(event, {
    group = grp,
    pattern = pattern,
    callback = function(ctx)
      local buf = ctx.buf

      local map = function(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = buf
        vim.keymap.set(mode, lhs, rhs, opts)
      end
      callback { buf = buf, evt = ctx, map = map }
    end,
  })
end

-- filetype-specific helper
function M.ftcmd(group, ft, callback)
  M.autocmd(group, 'FileType', ft, function(ctx)
    ctx.ft = ft
    callback(ctx)
  end)
end

return M
