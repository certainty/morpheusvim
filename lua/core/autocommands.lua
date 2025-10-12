local utils = require 'morpheus.utils'

local M = {}

function M.install(_) end

function M.configure(_)
  utils.ftcmd('CloseWithQ', { 'git', 'help', 'man', 'qf', 'scratch' }, function(ctx)
    ctx.map('n', 'q', '<cmd>quit<cr>')
  end)

  utils.autocmd('LastLocation', 'BufReadPost', '*', function(ctx)
    local mark = vim.api.nvim_buf_get_mark(ctx.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(ctx.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd 'normal! g`"zz'
    end
  end, { clear = true })

  utils.autocmd('YankFancy', 'TextYankPost', '*', function(_)
    vim.hl.on_yank { higroup = 'Visual' }
  end)
end

return M
