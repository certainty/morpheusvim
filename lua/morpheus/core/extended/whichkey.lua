if not Morpheus.is_enabled { 'core', 'whichkey' } then
  return {}
end

local whichkeySpec = {
  { '<leader>!', group = 'Diagnostics', mode = { 'n', 'v' } },
  { '<leader>c', group = 'Code', mode = { 'n', 'v' } },
  { '<leader>h', group = 'Help', mode = { 'n', 'v' } },
  { '<leader>g', group = 'Goto', mode = { 'n', 'v' } },
  { '<leader>s', group = 'Search', mode = { 'n', 'v' } },
  { '<leader>u', group = 'Ux', mode = { 'n' } },
  { '<leader>V', group = 'Morpheus', mode = { 'n' } },
  { '<leader>T', group = 'Treesitter', mode = { 'n' } },
  { '<localleader>,', group = 'At point', mode = { 'n', 'v' } },
  { '<localleader>c', group = 'Code', mode = { 'n', 'v' } },
  { '<localleader>h', group = 'Help', mode = { 'n', 'v' } },
  { '<localleader>s', group = 'Search', mode = { 'n', 'v' } },
  { 'g', group = 'Goto', mode = { 'n', 'v' } },
  { 's', group = 'Search', mode = { 'n' } },
  { '[', group = 'Prev', mode = { 'n', 'v' } },
  { ']', group = 'Next', mode = { 'n', 'v' } },
}

if Morpheus.is_enabled { 'ai' } then
  table.insert(whichkeySpec, { '<leader>a', group = 'AI', mode = { 'n', 'v' } })

  if Morpheus.is_enabled { 'ai', 'copilot' } then
    table.insert(whichkeySpec, { '<leader>ac', group = 'Copilot', mode = { 'n', 'v' } })
  end
end

if Morpheus.is_enabled { 'tools', 'git' } then
  table.insert(whichkeySpec, { '<leader>v', group = 'Git', mode = { 'n', 'v' } })
  table.insert(whichkeySpec, { '<localleader>,v', group = 'Git', mode = { 'n', 'v' } })
  table.insert(whichkeySpec, { '<localleader>v', group = 'Git', mode = { 'n', 'v' } })
end

if Morpheus.is_enabled { 'tools', 'terminal' } then
  table.insert(whichkeySpec, { '<leader>\\', group = 'Term', mode = { 'n', 'v' } })
end

if Morpheus.is_enabled { 'writing' } then
  table.insert(whichkeySpec, { '<leader>n', group = 'Notes', mode = { 'n', 'v' } })
end

return {
  {
    'folke/which-key.nvim',
    opts = {
      preset = 'helix',
      delay = 0.3,
      triggers = {
        { '<leader>', mode = { 'n', 'v' } },
        { '<localleader>', mode = { 'n', 'v' } },
        { '<localleader>,', mode = { 'n', 'v' } },
        { 'g', mode = { 'n', 'v' } },
        { 's', mode = { 'n' } },
        { '[', mode = { 'n', 'v' } },
        { ']', mode = { 'n', 'v' } },
      },
      win = {
        border = 'rounded',
      },
      sort = { 'local', 'order', 'group', 'alphanum', 'mod' },
      icons = {
        separator = ' ',
        group = ' +',
        keys = {},
      },
      spec = whichkeySpec,
    },
  },
}
