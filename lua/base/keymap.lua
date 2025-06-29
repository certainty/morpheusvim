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
  refactoring = { key = 'r', desc = 'Refactor' },

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
--- @param mode string|table specifying the mode(s) for the keymap
--- @param name_or_prefix string
--- @param bufnr number|nil
function M.group(mode, name_or_prefix, bufnr)
  local effective_prefix = '<leader>'

  if name_or_prefix then 
    local group = groups[name_or_prefix]
    if group then
      effective_prefix = effective_prefix .. group.key
    else
      effective_prefix = effective_prefix .. name_or_prefix
    end
  end

  local opts = {}
  if bufnr then
    opts.buffer = bufnr
  end

  return binder(mode or 'n', effective_prefix, opts)
end

--- Buffer-local group under `<localleader>`
---@param mode string|table
---@param name_or_prefix string|nil
---@param bufnr number|nil
function M.local_group(mode, name_or_prefix, bufnr)
  local effective_prefix = '<localleader>'

  if name_or_prefix then
    local group = groups[name_or_prefix]
    if group then
      effective_prefix = effective_prefix .. group.key
    else
      effective_prefix = effective_prefix .. name_or_prefix
    end
  end

  local opts = {}
  if bufnr then
    opts.buffer = bufnr
  end


  return binder(mode or 'n', effective_prefix, opts) 
end

--- At-point group under `<localleader>,`
--- @param mode string|table specifying the mode(s) for the keymap
--- @param name_or_prefix string|nil specifying the name or prefix for the keymap
--- @param bufnr number|nil specifying the buffer number for the keymap
function M.at_point(mode, name_or_prefix, bufnr)
  local effective_prefix = '<localleader>,'

  if name_or_prefix then
    local group = groups[name_or_prefix]
    if group then
      effective_prefix = effective_prefix .. group.key
    else
      effective_prefix = effective_prefix .. name_or_prefix
    end
  end

  local opts = {}
  if bufnr then
    opts.buffer = bufnr
  end

  return binder(mode or { 'n', 'v' }, effective_prefix, opts)
end

function M.whichkey_spec()
  local spec = {}
  for _, group in pairs(groups) do
    table.insert(spec, { '<leader>' .. group.key , group = group.desc, mode = { 'n', 'v' } })
    table.insert(spec, { '<localleader>,' .. group.key , group = group.desc, mode = { 'n', 'v' } })
  end

  table.insert(spec, {'<localleader>',  group = 'Mode Action', mode = { 'n', 'v' } })
  table.insert(spec, {'<localleader>,',  group = 'At point', mode = { 'n', 'v' } })
  return spec
end

return M
