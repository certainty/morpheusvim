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

      vim.keymap.set('n', '<leader>F', function()
        builtin.find_files { cwd = vim.fn.expand '%:p:h' }
      end, { desc = 'File relative to buffer' })

      vim.keymap.set('n', '<leader>f', builtin.git_files, { desc = 'Git Files' })
      vim.keymap.set('n', '<leader>gf', function()
        builtin.find_files { hidden = true }
      end, { desc = 'Files (hidden=true)' })
      vim.keymap.set('n', '<leader>gd', builtin.diagnostics, { desc = 'Diagnostics' })
      vim.keymap.set('n', '<leader>go', builtin.oldfiles, { desc = 'Recent Files ("o" for old)' })
      vim.keymap.set('n', '<leader>gb', builtin.buffers, { desc = 'Buffers buffers' })
      vim.keymap.set('n', '<leader>gi', require('telescope').extensions.aerial.aerial, { desc = 'aerial' })

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
      vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = 'Select Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Word' })
      vim.keymap.set('n', '<leader>ss', builtin.live_grep, { desc = 'Grep' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Resume' })

      vim.keymap.set('n', '<leader>gvb', builtin.git_branches, { desc = 'Git branches' })
      vim.keymap.set('n', '<leader>gvc', builtin.git_commits, { desc = 'Git commits' })

      vim.keymap.set('n', '<leader>x', builtin.commands, { desc = 'Commands' })
      vim.keymap.set('n', '<leader>ne', require('telescope').extensions.emoji.emoji, { desc = 'Emoji' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>gn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Neovim files' })
    end,
  },
}
