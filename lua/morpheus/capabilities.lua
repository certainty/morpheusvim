local M = {}

local utils = require 'morpheus.utils'

M.capabilities = {
  core = {},
  lang = {
    go = {},
    ruby = {},
    scala = {},
    terraform = {},
    json = {},
    yaml = {},
  },
  writing = { markdown = true },
  ai = { codecompanion = true, copilot = true },
  tools = { git = true, terminal = true },
}

function M.is_enabled(capability, sub)
  local c = M.capabilities[capability]

  if type(c) == 'boolean' then
    return c
  end

  if type(c) == 'table' then
    if sub then
      return c[sub]
    else
      return true
    end
  end

  return false
end

function M.each_enabled(cb)
  for capname, cap in pairs(M.capabilities) do
    if M.is_enabled(capname) then
      cb(capname, cap)
    end
  end
end

function M.each_disabled(cb)
  for capname, cap in pairs(M.capabilities) do
    if not M.is_enabled(capname) then
      cb(capname, cap)
    end
  end
end

function M.enable(capability, sub)
  if sub then
    M.capabilities[capability] = M.capabilities[capability] or {}
    M.capabilities[capability][sub] = true
  else
    M.capabilities[capability] = {}
  end
end

function M.disable(capability, sub)
  if sub then
    if type(M.capabilities[capability]) == 'table' then
      M.capabilities[capability][sub] = false
    end
  else
    M.capabilities[capability] = nil
  end
end

return M
