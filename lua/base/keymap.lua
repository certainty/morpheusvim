local M = {}


local groups = {
     ai =  { key = 'a', desc = 'AI' },
  code = { key = 'c', desc = 'Code' },
  debug = { key = 'd', desc = 'Debug' },
  test = { key = 't', desc = 'Test' },
  notes = { key = 'n', desc = 'Notes' },
  help = { key = 'h', desc = 'Help' },
  goto = { key = 'g', desc = 'Goto' },
  search = { key = 's', desc = 'Search' },
  ux = { key = 'u', desc = 'Ux' },
  format = { key = 'm', desc = 'Format' },
  vcs = { key = 'v', desc = 'Vcs' },
  workspace = { key = 'w', desc = 'Workspace' },
  diagnostics = { key = '!', desc = 'Diagnostics' },

  mode_local = { key = '<localleader>', desc = 'Mode actions' },
  at_point = { key = '<localleader>,', desc = 'At point' },
}

--- Internal helper to create mapper
--- @param mode string|table
--- @param prefix string
--- @param opts? table''
local function binder(mode, prefix, opts)
  opts = opts or {}
  return function(key, command, desc)
    vim.keymap.set(
      mode,
      prefix .. key,
      command,
      vim.tbl_extend('force', {
        desc = desc,
        noremap = true,
        silent = true,
      }, opts)
    )
  end
end

--- Create a global group under `<leader>x`
---@param name_or_prefix string
function M.group(mode, name_or_prefix)
  local group = groups[name_or_prefix]
  local effective_prefix = '<leader>'
  if group then
    effective_prefix = effective_prefix .. group.key
  else
    effective_prefix = effective_prefix .. name_or_prefix
  end

  return binder(mode or 'n', effective_prefix)
end

--- Buffer-local group under `<localleader>`
---@param mode string|table
---@param bufnr number
---@param name_or_prefix string
function M.local_group(mode, bufnr, name_or_prefix)
  local group = groups[name_or_prefix]
  local effective_prefix = '<localleader>'
  if group then
    effective_prefix = effective_prefix .. group.key
  else
    effective_prefix = effective_prefix .. name_or_prefix
  end
  return binder(mode or 'n', effective_prefix, { buffer = bufnr })
end

--- At-point group under `<localleader>,`
--- @param mode string|table specifying the mode(s) for the keymap
function M.at_point(mode, name_or_prefix)
  local group = groups[name_or_prefix]
  local effective_prefix = '<localleader>,'
  if group then
    effective_prefix = effective_prefix .. group.key
  end

  return binder(mode or { 'n', 'v' }, effective_prefix)
end

function M.whichkey_spec()
  local spec = {}
  for _, group in pairs(groups) do
    table.insert(spec, { '<leader>' .. group.key , group = group.desc, mode = { 'n', 'v' } })
    table.insert(spec, { '<localleader>' .. group.key  , group = group.desc, mode = { 'n', 'v' } })
    table.insert(spec, { '<localleader>,' .. group.key  , group = group.desc, mode = { 'n', 'v' } })
  end
  table.insert(spec, {'<localleader>,',  group = 'At point', mode = { 'n', 'v' } })
  return spec
end

return M
