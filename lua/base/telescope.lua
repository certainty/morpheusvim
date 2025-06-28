return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'nvim-telescope/telescope-bibtex.nvim' },
      { 'nvim-telescope/telescope-dap.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'stevearc/aerial.nvim' },
      { 'allaman/emoji.nvim' },
    },
    config = function()
      require('telescope').setup {
        defaults = require('telescope.themes').get_ivy(),
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_ivy(),
          },
          aerial = {
            col1_width = 4,
            col2_width = 30,
            format_symbol = function(symbol_path, filetype)
              if filetype == 'json' or filetype == 'yaml' then
                return table.concat(symbol_path, '.')
              else
                return symbol_path[#symbol_path]
              end
            end,
            show_columns = 'both',
          },
          bibtex = {
            global_files = { vim.fn.expand '~/Silos/Shared/Library/library.bib' },
            search_keys = { 'author', 'year', 'title' },
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'aerial')
      pcall(require('telescope').load_extension, 'emoji')
      pcall(require('telescope').load_extension, 'bibtex')
      pcall(require('telescope').load_extension 'dap')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Files' })

      local goto_map = require('base.keymap').group('n', 'goto')
      local search_map = require('base.keymap').group('n', 'search')
      local diagnostics_map = require('base.keymap').group('n', 'diagnostics')
      local help_map = require('base.keymap').group('n', 'help')

      goto_map('F', function()
        builtin.find_files { cwd = vim.fn.expand '%:p:h', hidden = true }
      end, 'File relative to buffer (hidden=true)')
      goto_map('f', builtin.git_files, 'Git Files')

      goto_map('o', builtin.oldfiles, 'Recent Files ("o" for old)')
      goto_map('b', builtin.buffers, 'Buffers buffers')
      goto_map('i', require('telescope').extensions.aerial.aerial, 'aerial')

      help_map('h', builtin.help_tags, 'Help tags')
      help_map('k', builtin.keymaps, 'Keymaps')

      vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = 'Select Telescope' })

      search_map('w', builtin.grep_string, 'Word')
      search_map('s', builtin.live_grep, 'Grep')
      search_map('r', builtin.resume, 'Resume')

      diagnostics_map('!', builtin.diagnostics, 'Diagnostics')

      goto_map('vb', builtin.git_branches, 'Git branches')
      goto_map('vc', builtin.git_commits, 'Git commits')

      help_map('c', builtin.commands, 'Commands')

      goto_map('n', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, 'Neovim data files')
    end,
  },
}
