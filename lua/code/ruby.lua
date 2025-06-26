return {
  'weizheheng/ror.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
  },

  config = function()
    require('ror').setup {
      -- Add your configuration here
      -- For example:
      -- default_ruby_version = '3.0.0',
      -- default_rails_version = '6.1.0',
      -- etc.
    }
    vim.keymap.set('n', '<Localleader>X', ":lua require('ror.commands').list_commands()<CR>", { silent = true, desc = 'List Rails Commands' })
  end,
}
