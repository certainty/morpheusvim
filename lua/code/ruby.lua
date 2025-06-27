return {
  'weizheheng/ror.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'ruby',
      callback = function()
        vim.keymap.set('n', '<Localleader>X', ":lua require('ror.commands').list_commands()<CR>", { silent = true, desc = 'List Rails Commands' })
        vim.keymap.set('n', '<localleader>f', '<cmd>RorFormat<CR>', {
          desc = 'Format Ruby File',
          buffer = 0,
        })
        vim.keymap.set('n', '<localleader>r', '<cmd>RorRun<CR>', {
          desc = 'Run Ruby File',
          buffer = 0,
        })
        vim.keymap.set('n', '<localleader>t', '<cmd>RorTest<CR>', {
          desc = 'Run Ruby Tests',
          buffer = 0,
        })
        vim.keymap.set('n', '<localleader>d', '<cmd>RorDebug<CR>', {
          desc = 'Debug Ruby File',
          buffer = 0,
        })
      end,
    })
  end,
  config = function()
    require('ror').setup {
      -- Add your configuration here
      -- For example:
      -- default_ruby_version = '3.0.0',
      -- default_rails_version = '6.1.0',
      -- etc.
    }
  end,
}
