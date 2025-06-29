return {
  'ray-x/go.nvim',
  dependencies = {
    'mfussenegger/nvim-dap',
    'leoluz/nvim-dap-go',
  },
  opts = {
    icons = false,
    lsp_keymaps = false,
    dap_debug_keymap = false,
    diagnostic = vim.g.diagnostic_config,
    iferr_vertical_shift = 2,
  },
  init = function()
    require('dap-go').setup()
    vim.filetype.add {
      extension = {
        gotmpl = 'gotmpl',
      },
      pattern = {
        ['.*/templates/.*%.tpl'] = 'helm',
        ['.*/templates/.*%.ya?ml'] = 'helm',
        ['helmfile.*%.ya?ml'] = 'helm',
      },
    }
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'go',
      callback = function(event)
        local local_format_map = require('base.keymap').local_group({ 'n', 'v' }, 'format', event.buf)
        local_format_map('f', '<cmd>GoFmt<CR>', 'Format Go File')

        local local_go_map = require('base.keymap').local_group({ 'n', 'v' }, nil, event.buf)

        local_go_map('t', '<cmd>GoTest<CR>', 'Run Go Tests')
        local_go_map('r', '<cmd>GoRun<CR>', 'Run Go File')
        local_go_map('i', '<cmd>GoInfo<CR>', 'Go Info')
        local_go_map('c', '<cmd>GoCoverageToggle<CR>', 'Toggle Go Coverage')
        local_go_map('t', '<cmd>GoModTidy<CR>', 'Go Mod Tidy')

        local go_at_point = require('base.keymap').at_point({ 'n', 'v' }, nil, event.buf)
        go_at_point('e', '<cmd>GoIfErr<CR>', 'Insert IfErr')
      end,
    })
  end,
  config = function(lp, opts)
    require('go').setup(opts)
  end,
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()',
}
