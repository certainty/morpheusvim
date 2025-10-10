local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
local diagnostic_signs = {}

for type, icon in pairs(signs) do
  diagnostic_signs[vim.diagnostic.severity[type]] = icon
end

vim.diagnostic.config {
  signs = { text = diagnostic_signs },
  virtual_text = false,
  underline = true,
  update_in_insert = true,
  virtual_lines = nil,
  float = {
    border = 'rounded'
  }
}

vim.keymap.set('n', '<leader>!', function() require('mini.extra').pickers.diagnostic() end,
  { desc = 'Diagnostics' })
