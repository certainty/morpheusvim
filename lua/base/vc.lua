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
        local vc_map = require('base.keymap').local_group('n', bufnr, 'vcs')
        local vc_visual_map = require('base.keymap').local_group('v', bufnr, 'vcs')

        vc_visual_map('s', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'git stage hunk')
        vc_visual_map('r', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'git reset hunk')

        vc_map('s', gitsigns.stage_hunk, 'stage hunk')
        vc_map('r', gitsigns.reset_hunk, 'reset hunk')
        vc_map('S', gitsigns.stage_buffer, 'stage buffer')
        vc_map('R', gitsigns.reset_buffer, 'reset buffer')
        vc_map('p', gitsigns.preview_hunk, 'preview hunk')
        vc_map('b', gitsigns.blame_line, 'blame line')
        vc_map('B', gitsigns.blame, 'blame')
        vc_map('d', gitsigns.diffthis, 'diff against index')
        vc_map('D', function()
          gitsigns.diffthis '@'
        end, 'diff against last commit')
        vc_map('tb', gitsigns.toggle_current_line_blame, 'toggle git show blame line')
      end,
    },
  },
}
