return {
  'mrjones2014/op.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-lua/telescope.nvim',
  },
  init = function()
    vim.keymap.set('n', '<leader>os', '<cmd>OpSignin<CR>', { noremap = true, silent = true, desc = 'Signin' })
    vim.keymap.set('n', '<leader>ox', '<cmd>OpSignout<CR>', { noremap = true, silent = true, desc = 'Signout' })
    vim.keymap.set('n', '<leader>oo', '<cmd>OpSidebar<CR>', { noremap = true, silent = true, desc = 'Sidebar' })
  end,
  build = 'make install',
  config = function()
    require('op').setup {
      -- you can change this to a full path if `op`
      -- is not on your $PATH
      op_cli_path = 'op',
      -- Whether to sign in on start.
      signin_on_start = false,
      -- show NerdFont icons in `vim.ui.select()` interfaces,
      -- set to false if you do not use a NerdFont or just
      -- don't want icons
      use_icons = true,
      -- settings for op.nvim sidebar
      sidebar = {
        -- sections to include in the sidebar
        sections = {
          favorites = true,
          secure_notes = true,
        },
        -- sidebar width
        width = 40,
        -- put the sidebar on the right or left side
        side = 'right',
        -- keymappings for the sidebar buffer.
        -- can be a string mapping to a function from
        -- the module `op.sidebar.actions`,
        -- an editor command string, or a function.
        -- if you supply a function, a table with the following
        -- fields will be passed as an argument:
        -- {
        --   title: string,
        --   icon: string,
        --   type: 'header' | 'item'
        --   -- data will be nil if type == 'header'
        --   data: nil | {
        --       uuid: string,
        --       vault_uuid: string,
        --       category: string,
        --       url: string
        --     }
        -- }
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
    }
  end,
}
