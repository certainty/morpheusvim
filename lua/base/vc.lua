return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
    },
    opts = {},
    keys = {
      { '<leader>vv', '<cmd>Neogit<CR>', desc = 'Git (neogit)' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    keys = {
      -- buffer local
      {
        ']c',
        function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            require('gitsigns').nav_hunk 'next'
          end
        end,
        buffer = 0,
        desc = 'Jump to next git [c]hange',
      },
      {
        '[c',
        function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            require('gitsigns').nav_hunk 'prev'
          end
        end,
        buffer = 0,
        desc = 'Jump to previous git [c]hange',
      },
      {
        '<leader>vs',
        function()
          require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        desc = 'git stage hunk',
        buffer = 0,
        mode = 'v',
      },
      {
        '<localleader>,vs',
        function()
          require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        desc = 'git stage hunk',
        buffer = 0,
        mode = 'n',
      },

      {
        '<leader>vr',
        function()
          require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        desc = 'git reset hunk',
        buffer = 0,
        mode = 'v',
      },
      {
        '<localleader>,vr',
        function()
          require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        desc = 'git reset hunk',
        buffer = 0,
        mode = 'n',
      },
      {
        '<localleader>,vp',
        function()
          require('gitsigns').preview_hunk()
        end,
        desc = 'preview hunk',
        buffer = 0,
        mode = 'n',
      },
      {
        '<localleader>,vb',
        function()
          require('gitsigns').blame_line()
        end,
        desc = 'blame line',
        buffer = 0,
        mode = 'n',
      },
      {
        '<leader>vB',
        function()
          require('gitsigns').blame()
        end,
        desc = 'blame',
        buffer = 0,
        mode = 'n',
      },
      {
        '<leader>vD',
        function()
          require('gitsigns').diffthis '@'
        end,
        desc = 'diff against last commit',
        buffer = 0,
        mode = 'n',
      },
      {
        '<leader>vtb',
        function()
          require('gitsigns').toggle_current_line_blame()
        end,
        desc = 'toggle blame',
        buffer = 0,
        mode = 'n',
      },
    },
    opts = {},
  },
}
