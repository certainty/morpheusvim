return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
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
        end, { desc = 'git stage hunk' })
        map('v', '<leader>br', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git reset hunk' })
        map('n', '<leader>vs', gitsigns.stage_hunk, { desc = 'stage hunk' })
        map('n', '<leader>vr', gitsigns.reset_hunk, { desc = 'reset hunk' })
        map('n', '<leader>vS', gitsigns.stage_buffer, { desc = 'stage buffer' })
        map('n', '<leader>vR', gitsigns.reset_buffer, { desc = 'reset buffer' })
        map('n', '<leader>vp', gitsigns.preview_hunk, { desc = 'preview hunk' })
        map('n', '<leader>vb', gitsigns.blame_line, { desc = 'blame line' })
        map('n', '<leader>vB', gitsigns.blame, { desc = 'blame' })
        map('n', '<leader>vd', gitsigns.diffthis, { desc = 'diff against index' })
        map('n', '<leader>vD', function()
          gitsigns.diffthis '@'
        end, { desc = 'diff against last commit' })
        map('n', '<leader>utb', gitsigns.toggle_current_line_blame, { desc = 'toggle git show blame line' })
      end,
    },
  },
}
