return {
  'nvim-mini/mini.nvim',
  lazy = false,
  version = '*',
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
  end,
}
