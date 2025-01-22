return {
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

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = require('telescope.themes').get_ivy(),
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_ivy(),
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Files' })

    vim.keymap.set('n', '<leader>F', function()
      builtin.find_files { cwd = vim.fn.expand '%:p:h' }
    end, { desc = 'File relative to buffer' })

    vim.keymap.set('n', '<leader>f', builtin.git_files, { desc = 'Git Files' })
    vim.keymap.set('n', '<leader>gd', builtin.diagnostics, { desc = 'Diagnostics' })
    vim.keymap.set('n', '<leader>go', builtin.oldfiles, { desc = 'Recent Files ("o" for old)' })
    vim.keymap.set('n', '<leader>gb', builtin.buffers, { desc = 'Buffers buffers' })

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = 'Select Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Word' })
    vim.keymap.set('n', '<leader>ss', builtin.live_grep, { desc = 'Grep' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Resume' })

    vim.keymap.set('n', '<leader>gvb', builtin.git_branches, { desc = 'Git branches' })
    vim.keymap.set('n', '<leader>gvc', builtin.git_commits, { desc = 'Git commits' })

    vim.keymap.set('n', '<leader>:', builtin.commands, { desc = 'Commands' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>gn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Neovim files' })
  end,
}
