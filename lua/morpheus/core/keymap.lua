return {
  {
    'folke/which-key.nvim',
    dependencies = {
      'nvim-mini/mini.icons',
      'nvim-mini/mini.pick',
      'nvim-mini/mini.extra',
    },
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
      spec = {
        { '<leader>!', group = 'Diagnostics', mode = { 'n', 'v' } },
        { '<leader>a', group = 'AI', mode = { 'n', 'v' } },
        { '<leader>ac', group = 'Copilot', mode = { 'n', 'v' } },
        { '<leader>h', group = 'Help', mode = { 'n', 'v' } },
        { '<leader>f', group = 'Find', mode = { 'n', 'v' } },
        { '<leader>u', group = 'Ux', mode = { 'n' } },
        { '<leader>V', group = 'Morpheus', mode = { 'n' } },
        { '<leader>T', group = 'Treesitter', mode = { 'n' } },
        { '<leader>o', group = '1pass', mode = { 'n', 'v' } },
        { '<leader>v', group = 'Git', mode = { 'n', 'v' } },
        { '<leader>\\', group = 'Term', mode = { 'n' } },
        { '<leader>n', group = 'Notes', mode = { 'n' } },
        { '<localleader>c', group = 'Code', mode = { 'n', 'v' } },
        { '<localleader>d', group = 'Debug', mode = { 'n', 'v' } },
        { '<localleader>t', group = 'Tests', mode = { 'n', 'v' } },
        { '<localleader>,', group = 'At point', mode = { 'n', 'v' } },
        { '<localleader>c', group = 'Code', mode = { 'n', 'v' } },
        { '<localleader>h', group = 'Help', mode = { 'n', 'v' } },
        { '<localleader>s', group = 'Search', mode = { 'n', 'v' } },
        { 'g', group = 'Goto', mode = { 'n', 'v' } },
        { 's', group = 'Search', mode = { 'n' } },
        { '[', group = 'Prev', mode = { 'n', 'v' } },
        { ']', group = 'Next', mode = { 'n', 'v' } },
      },
    },
    init = function()
      vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Quickfix list' })
      vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

      vim.keymap.set('n', '<localleader>,!', function()
        vim.diagnostic.open_float(nil, { focusable = false, scope = 'cursor' })
      end, { desc = 'diagnostics' })

      -- Term
      vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

      -- Windows
      vim.keymap.set('n', '<leader>|', '<cmd>vsplit<CR>', { desc = 'VSplit' })
      vim.keymap.set('n', '<leader>=', '<cmd>split<CR>', { desc = 'Split' })
      vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
      vim.keymap.set({ 'n', 'i', 'v' }, '<C-S-h>', ':vertical resize +10<CR>', { desc = 'Move focus to the left window' })
      vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
      vim.keymap.set({ 'n', 'i', 'v' }, '<C-S-l>', ':vertical resize -10<CR>', { desc = 'Resize vertical -' })
      vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
      vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
      vim.keymap.set('n', '<C-^>', '<cmd>b# <cr>', { desc = 'Switch to the last buffer' })
      vim.keymap.set('n', 'gb', '<cmd>b# <cr>', { desc = 'Switch to the last buffer' })

      -- quick file actions
      vim.api.nvim_set_keymap('n', 'E', '$', { noremap = false })
      vim.api.nvim_set_keymap('n', 'B', '^', { noremap = false })

      -- better editing
      vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
      vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
      vim.keymap.set('v', '>', '<cmd>>gv<CR>')
      vim.keymap.set('v', '<', '<cmd><gv<CR>')

      -- navigation in insert mode mimics emacs keybindings
      vim.keymap.set('i', '<C-a>', '<Home>', { desc = 'Move to the beginning of the line' })
      vim.keymap.set('i', '<C-e>', '<End>', { desc = 'Move to the end of the line' })
      vim.keymap.set('i', '<C-b>', '<Left>', { desc = 'Move left' })
      vim.keymap.set('i', '<C-f>', '<Right>', { desc = 'Move right' })

      require 'mini.pick'
      require 'mini.extra'

      vim.keymap.set('n', '<leader>fb', MiniPick.builtin.buffers, { desc = 'Buffers' })
      vim.keymap.set('n', '<leader>hh', MiniPick.builtin.help, { desc = 'Help' })
      vim.keymap.set('n', '<leader>hk', MiniExtra.pickers.keymaps, { desc = 'Keymaps' })
      vim.keymap.set('n', '<leader>fw', MiniPick.builtin.grep_live, { desc = 'Search in files' })
      vim.keymap.set('n', '<leader>fr', MiniPick.builtin.resume, { desc = 'Resume' })
      vim.keymap.set('n', '<leader><leader>', function()
        MiniPick.builtin.files { tool = 'git' }
      end, { desc = 'File (Git)' })

      vim.keymap.set('n', '<leader>ff', MiniPick.builtin.files, { desc = 'Files' })
      vim.keymap.set('n', '<leader>fo', MiniExtra.pickers.oldfiles, { desc = 'Recent' })
    end,
  },
}
