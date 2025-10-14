return {
  'nvim-mini/mini.basics',
  dependencies = {
    'nvim-mini/mini.bufremove',
  },
  lazy = false,
  config = function()
    require('mini.basics').setup {
      options = {
        basic = true,
        extra_ui = false,
        win_borders = 'auto',
      },

      mappings = {
        basic = true,
        option_toggle_prefix = [[\]],
        windows = false,
        move_with_alt = false,
      },

      autocommands = {
        basic = true,
        relnum_in_visual_mode = true,
      },
      silent = false,
    }

    vim.opt.mouse = ''
    vim.opt.cursorline = false
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true
    vim.opt.winborder = 'rounded'
    vim.o.signcolumn = 'yes'
    vim.o.cmdheight = 0

    require('mini.bufremove').setup()
    vim.keymap.set({ 'n' }, 'q', MiniBufremove.unshow, { desc = 'Hide Buffer' })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'git', 'help', 'man', 'qf', 'scratch' },
      callback = function()
        vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = true })
      end,
    })
    vim.api.nvim_create_autocmd('BufReadPost', {
      pattern = '*',
      callback = function()
        local mark = vim.api.nvim_buf_get_mark(ctx.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(ctx.buf)
        if mark[1] > 0 and mark[1] <= line_count then
          vim.cmd 'normal! g`"zz'
        end
      end,
    })
  end,
}
