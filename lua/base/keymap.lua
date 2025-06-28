local M = {}

-- Common top-level groups
local groups = {
  ai = '<leader>a',
  code = '<leader>c',
  debug = '<leader>d',
  test = '<leader>t',
  notes = '<leader>n',
  goto = '<leader>g',
  search = '<leader>s',
  ux = '<leader>u',
  format = '<leader>m',
  vcs = '<leader>v',
  workspace = '<leader>w',
  diganostics = '<leader>!',


  mode_local = '<localleader>',
  at_point = '<localleader>,',
}

--- Internal helper to create mapper
---@param mode string|table
---@param prefix string
---@param opts? table
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
---@param name string
function M.group(mode, name)
  return binder(mode or 'n', groups[name] or name)
end

--- Buffer-local group under `<localleader>`
---@param mode string|table
---@param bufnr number
---@param name string
function M.local_group(mode, bufnr, name)
  return binder(mode or 'n', groups[name] or name, { buffer = bufnr })
end

--- At-point group under `<localleader>,`
--- @param mode string|table specifying the mode(s) for the keymap
function M.at_point(mode)
  return binder(mode or { 'n', 'v' }, groups.at_point)
end

function M.whichkey_spec()
  return {
    { groups.ai, group = 'AI', mode = { 'n', 'v' } },
    { groups.code, group = 'Code', mode = { 'n', 'x', 'v' } },
    { groups.debug, group = 'Debug', mode = { 'n', 'v' } },
    { groups.test, group = 'Test', mode = { 'n', 'v'} },
    { groups.notes, group = 'Notes' },
    { groups.goto, group = 'Goto', mode = { 'n', 'v' } },
    { groups.search, group = 'Search', mode = { 'n', 'v' } },
    { groups.ux, group = 'Ux' },
    { groups.format, group = 'Format' },
    { groups.vcs, group = 'Vcs', mode = { 'n', 'v' } },
    { groups.workspace, group = 'Workspace', mode = { 'n', 'v' } },
    { groups.diganostics, group = 'Diagnostics', mode = { 'n', 'v' } },
    { groups.at_point, group = 'At point', mode = { 'n', 'v' } },
    { groups.mode_local, group = 'Mode actions', mode = { 'n', 'v' } },
  }
end

return M
