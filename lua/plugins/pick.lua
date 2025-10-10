vim.pack.add({ 'https://github.com/nvim-mini/mini.pick.git' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.extra.git' })

-- get_ivy style
local win_config = function()
  local height = math.floor(0.3 * vim.o.lines)
  local width = vim.o.columns
  return {
    anchor = 'NW',
    height = height,
    width = width,
    row = math.floor(vim.o.lines - height),
    col = math.floor(vim.o.columns),
  }
end


require('mini.pick').setup({
  window = { config = win_config },
  options = {
    content_from_bottom = false,
    use_icons = true
  }
})

vim.keymap.set('n', '<leader>gb', function() require('mini.pick').builtin.buffers() end, { desc = 'Buffers' })

vim.keymap.set('n', '<leader>hh', function() require('mini.pick').builtin.help() end, { desc = 'Help' })
vim.keymap.set('n', '<leader>hc', function() require('mini.pick').builtin.commands() end, { desc = 'Commands' })
vim.keymap.set('n', '<leader>hk', function() require('mini.extra').pickers.keymaps() end, { desc = 'Keymaps' })
