return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = function()
      vim.keymap.set('n', '<leader>vv', '<cmd>Neogit<CR>', { desc = 'vc (neogit)' })
      require('neogit').setup {}
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>vs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })
        map('v', '<leader>br', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })
        -- normal mode
        map('n', '<leader>vs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>vr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>vS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>vu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>vR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>vp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>vb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>vd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>vD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>utb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>utD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
}
