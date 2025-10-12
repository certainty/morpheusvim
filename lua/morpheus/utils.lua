-- lua/morpheus/utils.lua
local M = {}

--- @param table table
--- @param path table
function M.dig(table, path)
  local current = table

  for _, prop in ipairs(path) do
    current = current[prop]
    if current == nil then
      return false
    end
  end

  return current
end

function M.log(msg)
  vim.notify('[Morpheus] ' .. msg, vim.log.levels.INFO)
end
function M.warn(msg)
  vim.notify('[Morpheus] ' .. msg, vim.log.levels.WARN)
end
function M.error(msg)
  vim.notify('[Morpheus] ' .. msg, vim.log.levels.ERROR)
end

-- Create a group name for morpheus
--- @param group string
function M.groupName(group)
  return 'Morpheus/' .. group
end

-- Creates an auto command
--- @param group string
--- @param event string|table
--- @param pattern string
--- @param callback function
--- @param opts table | nil
function M.autocmd(group, event, pattern, callback, opts)
  opts = opts or { clear = false }
  local grp = vim.api.nvim_create_augroup(M.groupName(group), opts)

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

function M.clearAutoCmds(group, buffer)
  vim.api.nvim_clear_autocmds { group = M.groupName(group), buffer = buffer }
end

-- filetype-specific helper
function M.ftcmd(group, ft, callback, opts)
  M.autocmd(group, 'FileType', ft, function(ctx)
    ctx.ft = ft
    callback(ctx)
  end, opts)
end

return M
