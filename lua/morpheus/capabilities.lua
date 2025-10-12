local M = {}

local utils = require 'morpheus.utils'

M.configured = {
  core = { whichkey = false },
  ui = { theme = false, statusline = false },
  lang = {
    go = { treesitter = false, lsp = false, dap = false, test = false },
    ruby = { treesitter = false, lsp = false, dap = false, test = false },
    scala = { treesitter = false, lsp = false, dap = false, test = false },
    terraform = { treesitter = false, lsp = false, test = false },
    json = { treesitter = false, lsp = false },
    yaml = { treesitter = false, lsp = false },
  },
  writing = { markdown = true },
  ai = { codecompanion = { vectorcode = false, mcphub = false }, copilot = true },
  tools = { git = true, terminal = true },
}

-- Modules to load for each toplevel capability
M.modules = {
  core = { 'core.editing', 'core.whichkey', 'core.diagnostics', 'core.completion', 'core.keys', 'core.autocommands' },
  ui = { 'extras.ui.theme', 'extras.ui.statusline' },
  lang = {
    'extras.lang.treesitter',
    'extras.lang.lsp',
    -- 'extras.lang.dap',
    -- 'extras.lang.test',
    -- 'extras.lang.scala',
    -- 'extras.lang.ruby',
    -- 'extras.lang.config',
  },
  writing = {},
  ai = { 'extras.ai.copilot', 'extras.ai.codecompanion' },
  tools = {},
}

M.phases = {
  install = {},
  configure = {},
  clean = {},
}

local function safe_require(path)
  local ok, mod = pcall(require, path)
  if not ok then
    utils.warn('Failed to load module: ' .. path .. '\n' .. mod)
    return nil
  end
  return mod
end

local function call_timed(capname, mod, modpath, fn_name, ctx)
  local fn = mod[fn_name]

  if type(fn) ~= 'function' then
    utils.log('not a function ' .. type(fn))
    return
  end

  local start = vim.uv.hrtime()
  local ok, err = pcall(fn, ctx)
  local elapsed = (vim.uv.hrtime() - start) / 1e6 -- ms

  M.phases[fn_name][modpath] = {
    ok = ok,
    err = ok and nil or err,
    time_ms = elapsed,
  }

  if not ok then
    utils.error('Error in ' .. fn_name .. ' for ' .. capname .. ': ' .. err)
  end
end

function M.call_modules(capname, func, ctx)
  local mods = M.modules[capname]

  if mods then
    for _, modpath in pairs(mods) do
      local mod = safe_require(modpath)
      if mod then
        call_timed(capname, mod, modpath, func, ctx)
      end
    end
  end
end

function M.install_all()
  for capname, _ in pairs(M.configured) do
    M.call_modules(capname, 'install', M.configured)
  end
end

function M.configure_all()
  for capname, _ in pairs(M.configured) do
    M.call_modules(capname, 'configure', M.configured)
  end
end

function M.status()
  local lines = {}
  table.insert(lines, '🧩 MorpheusNvim Status\n')

  for phase, modules in pairs(M.phases) do
    table.insert(lines, '\n\n---  ' .. phase .. ' ----')
    for modpath, mod_info in pairs(modules) do
      local ok = mod_info and (mod_info.ok and '✅' or '❌') or ''
      local ms = mod_info and string.format(' (%.1fms)', mod_info.time_ms) or ''
      table.insert(lines, string.format('%s %s  %s', ok, modpath, ms))
    end
  end
  local msg = table.concat(lines, '\n')
  vim.notify(msg, vim.log.levels.INFO, { title = 'Morpheus Status' })
end

function M.status_buffer()
  local buf = vim.api.nvim_create_buf(false, true)
  local state = {
    phases = M.phases,
    capabilities = M.configured,
  }
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(vim.inspect(state), '\n'))
  vim.api.nvim_set_current_buf(buf)
end

return M
