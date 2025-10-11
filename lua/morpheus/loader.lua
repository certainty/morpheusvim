-- lua/morpheus/loader.lua
local cap = require 'morpheus.capabilities'
local utils = require 'morpheus.utils'

local M = {}

M.modules = {
  core = { 'core' },
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
}

local function safe_require(path)
  local ok, mod = pcall(require, path)
  if not ok then
    utils.warn('Failed to load module: ' .. path .. '\n' .. mod)
    return nil
  end
  return mod
end

local function call_timed(mod, modpath, fn_name, capname)
  local fn = mod[fn_name]

  if type(fn) ~= 'function' then
    utils.log('not a function ' .. type(fn))
    return
  end

  local start = vim.uv.hrtime()
  local ok, err = pcall(fn)
  local elapsed = (vim.uv.hrtime() - start) / 1e6 -- ms

  local existing = M.state.phases[fn_name][capname]
  if type(existing) ~= 'table' then
    M.state.phases[fn_name][capname] = {}
  end

  table.insert(M.state.phases[fn_name][capname], {
    mod = modpath,
    ok = ok,
    err = ok and nil or err,
    time_ms = elapsed,
  })

  if not ok then
    utils.error('Error in ' .. fn_name .. ' for ' .. capname .. ': ' .. err)
  end
end

function M.invoke_lifecycle(lifecycle)
  cap.each_enabled(function(capname, _)
    local mods = M.modules[capname]

    if mods then
      for _, modpath in pairs(mods) do
        local mod = safe_require(modpath)
        if mod then
          call_timed(mod, modpath, lifecycle, capname)
        end
      end
    end
  end)
end

function M.install_all()
  M.invoke_lifecycle 'install'
end

function M.configure_all()
  M.invoke_lifecycle 'configure'
end

function M.clean_all()
  cap.each_disabled(function(capname, _)
    local mods = M.modules[capname]

    if type(mods) == 'array' then
      for _, modpath in pairs(mods) do
        local mod = safe_require(modpath)

        if mod then
          call_timed(mod, 'clean', capname)
        end
      end
    end
  end)
end

function M.status()
  local lines = {}
  table.insert(lines, '🧩 MorpheusNvim Status\n')

  for capname, _ in pairs(M.modules) do
    local enabled = cap.is_enabled(capname)
    local symbol = enabled and '' or ''
    table.insert(lines, string.format('%s %-12s', symbol, capname))

    local phase_info = M.state.phases.configure[capname] or M.state.phases.install[capname]
    for _, mod_info in pairs(phase_info) do
      local ms = mod_info and string.format(' (%.1fms)', mod_info.time_ms) or ''
      local ok = mod_info and (mod_info.ok and '✅' or '❌') or ''
      table.insert(lines, string.format('   %s %-12s %s', ok, mod_info.mod, ms))
    end
  end

  local msg = table.concat(lines, '\n')
  vim.notify(msg, vim.log.levels.INFO, { title = 'Morpheus Status' })
end

function M.status_buffer()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(vim.inspect(M.state), '\n'))
  vim.api.nvim_set_current_buf(buf)
end

return M
