-- global key bindings
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = false })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Quickfix list' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- diagnostics
vim.keymap.set('n', '<leader>!', function()
  vim.diagnostic.open_float(nil, { focusable = false, scope = 'cursor' })
end, { desc = 'Show diagnostics at cursor' })

-- Term
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Windows
vim.keymap.set('n', '<leader>|', '<cmd>vsplit<CR>', { desc = 'VSplit' })
vim.keymap.set('n', '<leader>=', '<cmd>split<CR>', { desc = 'Split' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-{>', ':vertical resize +10<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-}>', ':vertical resize +10<CR>', { desc = 'Resize vertical -' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- quick file actions
vim.api.nvim_set_keymap('n', 'C-s', ':w!<enter>', { noremap = false })
vim.api.nvim_set_keymap('n', 'E', '$', { noremap = false })
vim.api.nvim_set_keymap('n', 'B', '^', { noremap = false })

-- better editing
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '>', '<cmd>>gv<CR>')
vim.keymap.set('v', '<', '<cmd><gv<CR>')
