vim.pack.add({ 'https://github.com/stevearc/oil.nvim.git' })

require('oil').setup({
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, bufnr)
      local m = name:match '^%.'
      return m ~= nil
    end,
  },
  is_always_hidden = function(name, bufnr)
    return false
  end,
  default_file_explorer = true,
  keymaps = {
    ['^'] = { 'actions.parent', mode = 'n' },
  },

})

vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'Dired' })
