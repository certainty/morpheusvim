vim.pack.add({ 'https://github.com/nvim-mini/mini.pick.git' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.extra.git' })

-- telescope ivy style
local ivy = function()
  local height = math.floor(0.3 * vim.o.lines)
  local width = vim.o.columns - 2
  return {
    anchor = 'NW',
    height = height,
    width = width,
    row = math.floor(vim.o.lines - height),
    col = math.floor(vim.o.columns - 2),
  }
end

require('mini.pick').setup({
  window = { config = ivy },
  options = {
    content_from_bottom = false,
    use_icons = true
  }
})

vim.keymap.set('n', '<leader>gb', function() require('mini.pick').builtin.buffers() end, { desc = 'Buffers' })

vim.keymap.set('n', '<leader>hh', function() require('mini.pick').builtin.help() end, { desc = 'Help' })
vim.keymap.set('n', '<leader>hc', function() require('mini.pick').builtin.commands() end, { desc = 'Commands' })
vim.keymap.set('n', '<leader>hk', function() require('mini.extra').pickers.keymaps() end, { desc = 'Keymaps' })

vim.keymap.set('n', '<leader>ss', function() require('mini.pick').builtin.grep_live() end, { desc = 'Search' })
vim.keymap.set('n', '<leader>sS', function() require('mini.pick').builtin.grep() end, { desc = 'Search*' })
vim.keymap.set('n', '<leader>gr', function() require('mini.pick').builtin.resume() end, { desc = 'Resume' })
