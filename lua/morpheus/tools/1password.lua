return {
  'mrjones2014/op.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>os', '<cmd>OpSignin<CR>', desc = '1Password Signin' },
    { '<leader>ox', '<cmd>OpSignout', desc = '1Password Signout' },
    { '<leader>oo', '<cmd>OpSidebar<CR>', desc = '1Password Sidebar' },
  },
  build = 'make install',
  opts = {
    op_cli_path = 'op',
    signin_on_start = false,
    use_icons = true,
    sidebar = {
      sections = {
        favorites = true,
        secure_notes = true,
      },
      width = 40,
      side = 'right',
      mappings = {
        ['<CR>'] = 'default_open',
        ['go'] = 'open_in_desktop_app',
        ['ge'] = 'edit_in_desktop_app',
      },
    },
    -- Custom formatter function for statusline component
    statusline_fmt = function(account_name)
      if not account_name or #account_name == 0 then
        return ' 1Password: No active session'
      end

      return string.format(' 1Password: %s', account_name)
    end,
    global_args = {
      -- use the item cache
      '--cache',
      '--no-color',
    },
    biometric_unlock = false,
    -- settings for Secure Notes editor
    secure_notes = {
      -- prefix for buffer names when
      -- editing 1Password Secure Notes
      buf_name_prefix = '1P:',
    },
    secret_detection_diagnostics = {
      disabled = false,
      severity = vim.diagnostic.severity.WARN,
      max_file_lines = 10000,
      disabled_filetypes = {
        'nofile',
        'TelescopePrompt',
        'NvimTree',
        'Trouble',
        '1PasswordSidebar',
      },
    },
  },
}
