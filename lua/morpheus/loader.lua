-- lua/morpheus/loader.lua
local cap = require 'morpheus.capabilities'
local utils = require 'morpheus.utils'

local M = {}

M.modules = {
  -- lsp = 'extras.code.lsp',
  -- treesitter = 'extras.code.treesitter',
  -- dap = 'extras.code.dap',
  -- test = 'extras.code.tests',
  -- writing = 'extras.writing.markdown',
  -- ai = 'extras.ai',
  -- git = 'extras.tools.git',
  -- terminal = 'extras.tools.terminal',
}

M.state = {
  phases = {
    install = {},
    configure = {},
    clean = {},
  },
  loaded_modules = {},
}

local function safe_require(path)
  local ok, mod = pcall(require, path)
  if not ok then
    utils.warn('Failed to load module: ' .. path .. '\n' .. mod)
    return nil
  end
  return mod
end

local function call_timed(mod, fn_name, capname)
  local fn = mod[fn_name]
  if type(fn) ~= 'function' then
    return
  end

  local start = vim.uv.hrtime()
  local ok, err = pcall(fn)
  local elapsed = (vim.uv.hrtime() - start) / 1e6 -- ms

  M.state.phases[fn_name][capname] = {
    ok = ok,
    err = ok and nil or err,
    time_ms = elapsed,
  }

  if not ok then
    utils.error('Error in ' .. fn_name .. ' for ' .. capname .. ': ' .. err)
  end
end

function M.install_all()
  for capname, modpath in pairs(M.modules) do
    if cap.is_enabled(capname) then
      local mod = safe_require(modpath)
      if mod then
        M.state.loaded_modules[capname] = modpath
        call_timed(mod, 'install', capname)
      end
    end
  end
end

function M.configure_all()
  for capname, modpath in pairs(M.modules) do
    if cap.is_enabled(capname) then
      local mod = safe_require(modpath)
      if mod then
        call_timed(mod, 'configure', capname)
      end
    end
  end
end

function M.clean_all()
  for capname, modpath in pairs(M.modules) do
    if not cap.is_enabled(capname) then
      local mod = safe_require(modpath)
      if mod then
        call_timed(mod, 'clean', capname)
      end
    end
  end
end

function M.status()
  local lines = {}
  table.insert(lines, '🧩 MorpheusNvim Status\n')

  for capname, modpath in pairs(M.modules) do
    local enabled = cap.is_enabled(capname)
    local phase_info = M.state.phases.configure[capname] or M.state.phases.install[capname]
    local ms = phase_info and string.format(' (%.1fms)', phase_info.time_ms) or ''
    local ok = phase_info and (phase_info.ok and '✅' or '❌') or ''
    local symbol = enabled and '' or ''
    table.insert(lines, string.format('%s %-12s %s%s', symbol, capname, ok, ms))
  end

  local msg = table.concat(lines, '\n')
  vim.notify(msg, vim.log.levels.INFO, { title = 'Morpheus Status' })
end

return M
