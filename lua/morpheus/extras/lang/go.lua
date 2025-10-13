local utils = require 'morpheus.utils'

return {
  'ray-x/go.nvim',
  build = ':lua require("go.install").update_all_sync()',
  ft = { 'go', 'gomod' },
  event = { 'CmdlineEnter' },
  dependencies = {
    'ray-x/guihua.lua',
  },
  opts = {
    icons = false,
    lsp_keymaps = false,
    dap_debug_keymap = false,
    diagnostic = vim.g.diagnostic_config,
    iferr_vertical_shift = 2,
  },
  init = function()
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

    utils.ftcmd('GoLang', { 'go', 'gomod', 'gosum' }, function(ctx)
      ctx.map('n', '<localleader>f', '<cmd>GoFmt<CR>', 'Format Go File')
      ctx.map('n', '<localleader>t', '<cmd>GoTest<CR>', 'Run Go Tests')
      ctx.map('n', '<localleader>r', '<cmd>GoRun<CR>', 'Run Go File')
      ctx.map('n', '<localleader>i', '<cmd>GoInfo<CR>', 'Go Info')
      ctx.map('n', '<localleader>c', '<cmd>GoCoverageToggle<CR>', 'Toggle Go Coverage')
      ctx.map('n', '<localleader>t', '<cmd>GoModTidy<CR>', 'Go Mod Tidy')

      if Morpheus.is_enabled { 'lang', 'go', 'dap' } then
        ctx.map('n', '<localleader>d', '<cmd>GoDebug<cr>', 'Debug')
      end

      ctx.map({ 'n', 'v' }, '<localleader>,e', '<cmd>GoIfErr<cr>', 'Insert IfErr')
    end)
  end,
}
